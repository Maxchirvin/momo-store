variable "yandex_cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
  sensitive   = true
}

variable "yandex_folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
  default     = "b1g6tdpfgpqprbffhjje"
}

variable "yandex_zone" {
  description = "Yandex Cloud zone"
  type        = string
  default     = "ru-central1-b"
}

variable "yandex_token" {
  description = "Yandex Cloud OAuth token"
  type        = string
  sensitive   = true
}

variable "s3_access_key" {
  description = "S3 access key for Terraform backend"
  type        = string
  sensitive   = true
}

variable "s3_secret_key" {
  description = "S3 secret key for Terraform backend"
  type        = string
  sensitive   = true
}
