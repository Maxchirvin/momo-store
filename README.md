# Momo Store - Интернет магазин

## Демонстрация инфраструктуры
- **URL приложения**: http://momo-store.158.160.137.12.nip.io
- **Kubernetes кластер**: momo-store-k8s-cluster
- **Внешний IP**: 158.160.137.12

## Архитектура
- **Frontend**: Vue.js приложение в Kubernetes
- **Backend**: Go API сервис  
- **База данных**: Yandex Object Storage (S3)
- **Ingress**: Nginx Ingress Controller

## Инфраструктура
- Kubernetes кластер с 2 узлами
- S3 бакеты для хранения данных
- GitLab CI/CD для автоматизации
- Terraform для управления инфраструктурой

## Развертывание
```bash
kubectl apply -f infrastructure/k8s/ -n momo-store
