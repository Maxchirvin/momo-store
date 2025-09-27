resource "yandex_storage_bucket" "images" {
  bucket = var.images_bucket_name
  acl    = "private"
}

resource "yandex_storage_bucket" "tf_state" {
  bucket = var.tf_state_bucket_name
  acl    = "private"
}

output "images_bucket_name" {
  value = yandex_storage_bucket.images.bucket
}

output "tf_state_bucket_name" {
  value = yandex_storage_bucket.tf_state.bucket
}
