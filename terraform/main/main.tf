terraform {
    backend "s3" {
      bucket = "tfstateshop-kins"
      key = "app-state"
      region = "eu-west-3"
    }
}

provider "aws" {
  region = "eu-west-3"
}

module chef {
  source = "./modules/chef_cookbooks"
  bucket_name = var.bucket_name
}