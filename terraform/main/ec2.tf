data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

resource "aws_instance" "server" {
  ami           = data.aws_ami.amazon-linux-2.id
  instance_type = "t2.micro"

  tags = var.tags

  iam_instance_profile = aws_iam_instance_profile.instance_profile.name

  vpc_security_group_ids = [aws_security_group.phrase_sg.id]

  user_data_replace_on_change = true
  user_data = templatefile(
    "${path.module}/templates/userdata.cfg",
    {
      admin_public_key = file("${path.module}/resources/phrase_admin.pub"),
      user_public_key = file("${path.module}/resources/phrase_user.pub"),
      shopkins_public_key = file("${path.module}/resources/shopkins.pub"),
      chef_cron_script = file("${path.module}/resources/chef_cron_script.sh")
    }
  )
}