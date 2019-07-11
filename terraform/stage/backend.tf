terraform {
  backend "gcs" {
    bucket = "storage-bucket-bars83-2"
    prefix = "stage"
  }
}
