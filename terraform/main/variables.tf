variable "tags" {
  default = {
    Name = "Phrase-Python-Server"
    IAC = true
    source = "shop-kins/PHRASE"
  }
}

variable "region" {
  default = "eu-west-3"
}

variable "bucket_name" {
  default = "shop-kins-chef-bucket"
}