terraform {
    backend "s3" {
      bucket = "tfstateshop-kins"
      key = "app-state"
      region = "us-east-1"
    }
}