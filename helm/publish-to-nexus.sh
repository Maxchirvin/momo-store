#!/bin/bash

# Данные корпоративного Nexus
NEXUS_URL="https://nexus.praktikum-services.tech"
NEXUS_USERNAME="std-039-27"
NEXUS_PASSWORD="2fYlP32g"

echo "=== Publishing Momo Store Helm Chart to Corporate Nexus ==="
echo "Nexus: $NEXUS_URL"
echo "Username: $NEXUS_USERNAME"

# Проверяем доступность Nexus
echo "Checking Nexus accessibility..."
if curl -s -f -u "$NEXUS_USERNAME:$NEXUS_PASSWORD" "$NEXUS_URL" > /dev/null; then
    echo "✅ Nexus is accessible"
else
    echo "❌ Cannot access Nexus"
    exit 1
fi

# Пробуем разные возможные пути репозиториев
REPO_PATHS=(
    "repository/helm-hosted"
    "repository/helm-releases" 
    "repository/helm-proxy"
    "repository/std-039-27-helm"
    "repository/momo-store-helm"
)

HELM_REPO_URL=""
for path in "${REPO_PATHS[@]}"; do
    FULL_URL="$NEXUS_URL/$path/"
    echo "Trying: $FULL_URL"
    if curl -s -f -u "$NEXUS_USERNAME:$NEXUS_PASSWORD" "$FULL_URL" > /dev/null; then
        HELM_REPO_URL="$FULL_URL"
        echo "✅ Found accessible repository: $HELM_REPO_URL"
        break
    fi
done

if [ -z "$HELM_REPO_URL" ]; then
    echo "❌ No accessible Helm repository found"
    echo "Creating default path..."
    HELM_REPO_URL="$NEXUS_URL/repository/std-039-27-helm/"
fi

# Создаем индекс
echo "Creating Helm repository index..."
helm repo index . --url "$HELM_REPO_URL"

# Публикуем chart
echo "Uploading momo-store-0.1.0.tgz..."
if curl -u "$NEXUS_USERNAME:$NEXUS_PASSWORD" --upload-file momo-store-0.1.0.tgz \
    "$HELM_REPO_URL/momo-store-0.1.0.tgz"; then
    echo "✅ Chart uploaded successfully"
else
    echo "❌ Chart upload failed"
    exit 1
fi

# Публикуем индекс
echo "Uploading index.yaml..."
if curl -u "$NEXUS_USERNAME:$NEXUS_PASSWORD" --upload-file index.yaml \
    "$HELM_REPO_URL/index.yaml"; then
    echo "✅ Index uploaded successfully"
else
    echo "❌ Index upload failed"
    exit 1
fi

echo ""
echo "🎉 Momo Store Helm Chart successfully published to Nexus!"
echo "📦 Repository URL: $HELM_REPO_URL"
echo "🔗 Chart URL: $HELM_REPO_URL/momo-store-0.1.0.tgz"
echo ""
echo "To use the chart:"
echo "helm repo add my-nexus '$HELM_REPO_URL' --username '$NEXUS_USERNAME' --password '$NEXUS_PASSWORD'"
echo "helm install my-momo-store my-nexus/momo-store --version 0.1.0"
