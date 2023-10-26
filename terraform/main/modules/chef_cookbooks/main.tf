data "archive_file" "chef_cookbook_archive" {
  type = "zip"
  source_dir = "${path.module}/../../../../chef"
  output_path = "chef_cookbooks.zip"
}

resource "aws_s3_object" "file_upload" {
  bucket = aws_s3_bucket.my_chef_bucket.id
  key    = "chef_cookbooks.zip"
  source = "chef_cookbooks.zip"
  source_hash = data.archive_file.chef_cookbook_archive.output_base64sha256
}