terraform {
  backend "gcs" {
    bucket = "storage-bucket-bars83-1"
    prefix = "stage"
  }
}
