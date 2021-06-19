resource "aws_lb" "load-balancer" {
  name               = "load-balancer"
  internal           = false
  load_balancer_type = "application"
  subnets            = module.apache-vpc.public_subnets

  enable_deletion_protection = false
  depends_on                 = [module.apache-vpc, aws_security_group.apache_sg, ]

  security_groups = [aws_security_group.apache_sg.id, ]
  tags = {
    Environment = "production"
  }
}


resource "aws_lb_target_group" "apache_target_group" {
  name     = "apache-target-group"
  port     = 80
  protocol = "HTTP"
  health_check {
    path     = "/"
    protocol = "HTTP"
    port     = 80
    timeout  = 30
    interval = 60

  }

  vpc_id = module.apache-vpc.vpc_id
}

resource "aws_lb_listener" "apache_listener" {
  load_balancer_arn = aws_lb.load-balancer.id
  port              = 443
  protocol          = "HTTPS"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.apache_target_group.arn
  }
  certificate_arn = var.acm_arn
}

resource "aws_lb_listener_certificate" "apache" {
  listener_arn    = aws_lb_listener.apache_listener.arn
  certificate_arn = var.acm_arn

}


resource "aws_lb_listener_rule" "apache_listener_rule" {
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.apache_target_group.arn
  }

  listener_arn = aws_lb_listener.apache_listener.arn
  priority     = 100

  condition {
    host_header {
      values = ["${var.cf_cname}.${var.cf_zone}", ]
    }
  }
  depends_on = [aws_lb_listener_certificate.apache, ]

}


//arn:aws:acm:ap-south-1:623164150455:certificate/08307b92-3a8b-49a3-96ea-187957aceb50


resource "aws_lb_target_group_attachment" "apache_target" {
  count            = var.instance_count
  target_group_arn = aws_lb_target_group.apache_target_group.arn
  target_id        = aws_instance.apache_ec2[count.index].id
  port             = 80
}

