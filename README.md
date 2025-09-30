# Momo Store - Интернет магазин вкусных пельменей взятые из репозитория Стасяна. Покупайте наши пельмени и будете довольны!

## Пельменная №2 ![Логотип Momo Store](img/1.png)
URL сайта http://89.169.163.211:30080/momo-store/catalog

## Инфраструктура
````
momo-store/
├── backend/                 # Golang бэкенд
│   ├── cmd/api/             # Точка входа приложения
│   ├── internal/            # Внутренние пакеты
│   ├── Dockerfile           # Образ бэкенда
│   └── metrics.go           # Метрики Prometheus
├── frontend/                # Vue.js фронтенд
│   ├── public/              # Статические файлы
│   ├── src/                 # Исходный код
│   └── Dockerfile           # Образ фронтенда
├── img/                     # Изображения для README и фронтенда
│   └── 1.png
├── infrastructure/          # Инфраструктура как код
│   ├── k8s/                 # Kubernetes манифесты
│   │   ├── backend-deployment.yaml
│   │   ├── frontend-deployment.yaml
│   │   ├── ingress.yaml
│   │   ├── ingress-correct.yaml
│   │   └── ingress-fixed.yaml
│   ├── kubernetes/          # Базовые конфигурации
│   │   └── momo-store-with-metrics.yaml
│   ├── monitoring/          # Мониторинг: Grafana, Prometheus, Loki
│   │   ├── kubernetes-dashboard.yaml
│   │   ├── loki-values.yaml
│   │   ├── momo-store-dashboard.yaml
│   │   ├── prometheus-stack.yaml
│   │   └── setup-monitoring.sh
│   ├── nexus/               # Nexus репозиторий
│   │   ├── nexus-deployment.yaml
│   │   ├── nexus-deployment-init.yaml
│   │   ├── nexus-deployment-simple.yaml
│   │   └── nexus-deployment-fixed.yaml
│   └── terraform/           # Terraform инфраструктура + CI/CD
│       ├── modules/disabled               # Отключённые модули Terraform
│       ├── .gitignore                      # Игнорируемые файлы для Terraform
│       ├── .terraform.lock.hcl            # Lock-файл провайдеров Terraform
│       ├── backend.tf                       # Конфигурация backend для хранения состояния в S3
│       ├── go-deps-report.json             # Отчёт зависимостей Go для CI/CD
│       ├── main.tf                          # Основной Terraform конфиг (ресурсы, провайдеры)
│       ├── npm-audit-report.json           # Отчёт проверки npm-пакетов (CI/CD)
│       ├── sonar-project.properties        # Конфигурация SonarQube для анализа кода
│       ├── terraform.tfstate               # Состояние Terraform
│       ├── terraform.tfstate.backup        # Резервная копия состояния Terraform
│       ├── terraform.tfvars                # Значения переменных для Terraform
│       ├── tfplan                          # План Terraform (для применения изменений)
│       └── variables.tf                    # Определение переменных Terraform
├── .gitignore               # Игнорируемые файлы для git
├── .gitlab-ci.yml           # CI/CD конфигурация
├── README.md                # Этот файл
└── setup-corporate-nexus-docker.sh # Скрипт настройки Nexus для CI/CD