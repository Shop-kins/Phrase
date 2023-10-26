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

resource "aws_security_group_rule" "inbound_https" {
  from_port = 5001
  protocol = "TCP"
  security_group_id = aws_security_group.phrase_sg.id
  to_port = 5002
  type = "ingress"
  source_security_group_id = aws_security_group.inbound_lb.id
}

resource "aws_security_group_rule" "allow_all_outbound" {
  from_port = 0
  protocol = -1
  security_group_id = aws_security_group.phrase_sg.id
  to_port = 0
  type = "egress"
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group" "inbound_lb" {
  name = "inbound_lg"
  vpc_id = data.aws_vpc.default.id
  tags = var.tags
}

resource "aws_security_group_rule" "inbound_https_lb" {
  from_port = 443
  protocol = "TCP"
  security_group_id = aws_security_group.inbound_lb.id
  to_port = 443
  type = "ingress"
  cidr_blocks = [ "0.0.0.0/0" ]
}
