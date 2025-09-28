#!/bin/bash

NEXUS_URL="https://nexus.praktikum-services.tech"
NEXUS_USERNAME="std-039-27"
NEXUS_PASSWORD="2fYlP32g"

echo "=== Настройка Docker в корпоративном Nexus ==="

# Проверим доступные репозитории
echo "1. Проверяем существующие репозитории..."
curl -s -u $NEXUS_USERNAME:$NEXUS_PASSWORD \
  "$NEXUS_URL/service/rest/v1/repositories" | jq '.[] | .name + " - " + .type'

# Создаем Docker hosted репозиторий (если нет подходящего)
echo "2. Создаем Docker репозиторий..."
curl -u $NEXUS_USERNAME:$NEXUS_PASSWORD -X POST \
  "$NEXUS_URL/service/rest/v1/repositories/docker/hosted" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "std-039-27-docker",
    "online": true,
    "docker": {
      "v1Enabled": false,
      "forceBasicAuth": true,
      "httpPort": 5000
    },
    "storage": {
      "blobStoreName": "default",
      "strictContentTypeValidation": true,
      "writePolicy": "allow_once"
    }
  }'

echo "3. Настраиваем Docker аутентификацию..."
DOCKER_REGISTRY="$NEXUS_URL/repository/std-039-27-docker"
docker login $DOCKER_REGISTRY -u $NEXUS_USERNAME -p $NEXUS_PASSWORD

echo "Docker репозиторий настроен: $DOCKER_REGISTRY"
