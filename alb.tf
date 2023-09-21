##### ALB - Application Load Balancing #####
##### ALB - Load Balancer #####
resource "aws_lb" "loadbalancer" {
  internal           = "false" # internal = true else false
  name               = "${var.namespace}-ALB-${var.environment}"
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets # Subnets públicas
  security_groups    = [aws_security_group.public.id]
}

##### ALB - Target Groups #####


resource "aws_alb_target_group" "alb_public_webservice_target_group" {
  name     = "${var.namespace}-TargetGroup-${var.environment}"
  port     = "5001"
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    healthy_threshold   = "3"
    interval            = "15"
    path                = "/service-1"
    protocol            = "HTTP"
    unhealthy_threshold = "10"
    timeout             = "10"
  }
}
##### ALB - Listeners #####

resource "aws_lb_listener" "lb_listener-webservice-https" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_public_webservice_target_group.id
  }
}
output "this_lb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = aws_lb.loadbalancer.dns_name
}
