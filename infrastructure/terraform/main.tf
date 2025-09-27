terraform {
  required_version = ">= 1.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.95.0"
    }
  }
}

provider "yandex" {
  token     = var.yandex_token
  cloud_id  = var.yandex_cloud_id
  folder_id = var.yandex_folder_id
  zone      = var.yandex_zone
}

# Создаем сеть (уже создана)
resource "yandex_vpc_network" "momo_network" {
  name = "momo-store-network-tf"
}

resource "yandex_vpc_subnet" "momo_subnet" {
  name           = "momo-store-subnet-tf"
  zone           = var.yandex_zone
  network_id     = yandex_vpc_network.momo_network.id
  v4_cidr_blocks = ["10.10.0.0/16"]
}

# Сервисные аккаунты (уже созданы)
resource "yandex_iam_service_account" "k8s_sa" {
  name        = "k8s-cluster-sa-tf"
  description = "Service account for Kubernetes cluster management (Terraform)"
}

resource "yandex_iam_service_account" "k8s_node_sa" {
  name        = "k8s-node-sa-tf"
  description = "Service account for Kubernetes worker nodes (Terraform)"
}

# Права для сервисных аккаунтов (уже созданы)
resource "yandex_resourcemanager_folder_iam_member" "k8s_sa_editor" {
  folder_id = var.yandex_folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.k8s_sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s_node_sa_puller" {
  folder_id = var.yandex_folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.k8s_node_sa.id}"
}

# Data source для существующего кластера
data "yandex_kubernetes_cluster" "existing_cluster" {
  name = "momo-store-k8s-cluster"
}

output "network_id" {
  value = yandex_vpc_network.momo_network.id
}

output "subnet_id" {
  value = yandex_vpc_subnet.momo_subnet.id
}

output "existing_k8s_cluster" {
  value = data.yandex_kubernetes_cluster.existing_cluster.id
}

output "k8s_external_endpoint" {
  value = data.yandex_kubernetes_cluster.existing_cluster.master[0].external_v4_endpoint
}
