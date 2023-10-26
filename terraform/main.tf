terraform {
    backend "s3" {
      bucket = "tfstateshop-kins"
      key = "app-state"
      region = "eu-west-3"
    }
}