data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "phrase_sg" {
  name = "phrase_sg"
  vpc_id = data.aws_vpc.default.id
  tags = var.tags
}

resource "aws_security_group_rule" "inbound_ssh" {
  from_port = 22
  protocol = "TCP"
  security_group_id = aws_security_group.phrase_sg.id
  to_port = 22
  type = "ingress"
  cidr_blocks = [ "0.0.0.0/0" ]
}