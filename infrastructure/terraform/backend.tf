# Локальное состояние для тестирования
# В продакшене заменить на S3
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
