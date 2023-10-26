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

  tags = {
    Name = "Phrase-Python-Server"
    IAC = true
    source = "shop-kins/PHRASE"
  }

  vpc_security_group_ids = [aws_security_group.phrase_sg.id]

  user_data = templatefile(
    "${path.module}/templates/userdata.sh",
    {
      admin_public_key = file("${path.module}/resources/phrase_admin.pub"),
      user_public_key = file("${path.module}/resources/phrase_user.pub"),
      shopkins_public_key = file("${path.module}/resources/shopkins.pub")
    }
  )
}