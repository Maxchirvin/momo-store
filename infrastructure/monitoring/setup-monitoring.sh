#!/bin/bash

echo "Setting up monitoring stack for Momo Store..."

# Create monitoring namespace
kubectl create namespace monitoring

# Install Prometheus Stack
helm upgrade --install prometheus-stack prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --set grafana.adminPassword=admin123 \
  --set prometheus.service.type=LoadBalancer \
  --set grafana.service.type=LoadBalancer \
  --set grafana.persistence.enabled=true \
  --set grafana.persistence.size=10Gi \
  --atomic --wait --timeout=10m

# Install Loki for logs
helm upgrade --install loki grafana/loki-stack \
  --namespace monitoring \
  --set grafana.enabled=false \
  --set promtail.enabled=true \
  --atomic --wait --timeout=5m

# Wait for services to be ready
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=grafana -n monitoring --timeout=300s

# Get access information
echo "Monitoring stack installed successfully!"
echo "Grafana URL: https://std-039-27-grafana.k8s.praktikum-services.tech/"
echo "Username: admin"
echo "Password: admin123"

# Port-forward for local access
echo "For local access, run: kubectl port-forward -n monitoring service/prometheus-stack-grafana 3000:80"
