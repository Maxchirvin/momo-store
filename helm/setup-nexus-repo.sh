#!/bin/bash

NEXUS_URL="http://158.160.167.145:8081"
USERNAME="admin"
PASSWORD=""

echo "Setting up Helm repository in Nexus..."

# Создаем hosted Helm репозиторий
curl -u student: -X POST   "http://your-nexus-url/repository/helm-repo/service/rest/v1/repositories/helm/hosted"   -H "Content-Type: application/json"   -d '{
    "name": "momo-store-helm",
    "online": true,
    "storage": {
      "blobStoreName": "default",
      "strictContentTypeValidation": true,
      "writePolicy": "allow_once"
    },
    "cleanup": null
  }'

echo ""
echo "Helm repository created successfully!"
echo "Repository URL: http://your-nexus-url/repository/helm-repo/repository/momo-store-helm/"
