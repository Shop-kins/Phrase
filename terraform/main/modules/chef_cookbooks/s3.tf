resource "aws_s3_bucket" "my_chef_bucket" {
  bucket = var.bucket_name
}