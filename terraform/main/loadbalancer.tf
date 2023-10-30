data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_lb" "test" {
  name               = "phrase-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.inbound_lb.id]
  subnets = data.aws_subnets.subnets.ids

  enable_deletion_protection = false

  tags = var.tags
}

resource "aws_lb_listener" "phrase2" {
  load_balancer_arn = aws_lb.test.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "phrase1" {
  load_balancer_arn = aws_lb.test.arn
  certificate_arn = aws_acm_certificate.cert.arn
  port = "443"
  protocol = "HTTPS"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.phrase.arn
  }
}

resource "aws_lb_target_group" "phrase" {
  name = "application-phrase1"
  port = 443
  protocol = "HTTP"
  vpc_id = data.aws_vpc.default.id

  health_check {
    path = "/status"
    healthy_threshold = 6
    unhealthy_threshold = 2
    timeout = 2
    interval = 5
    matcher = "200"  # has to be HTTP 200 or fails
  }
}

resource "aws_lb_target_group_attachment" "phrase1" {
  target_group_arn = aws_lb_target_group.phrase.arn
  target_id = aws_instance.server.id
  port = 5001
}

resource "aws_lb_target_group_attachment" "phrase2" {
  target_group_arn = aws_lb_target_group.phrase.arn
  target_id = aws_instance.server.id
  port = 5002
}