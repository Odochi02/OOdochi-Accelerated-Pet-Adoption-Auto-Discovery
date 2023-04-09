# creating docker target group
resource "aws_lb_target_group" "docker-prod-tg" {
  name     = "docker-prod-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}
#creating docker prod load balancer target group attachment
resource "aws_lb_target_group_attachment" "docker_prod_tg_attachment" {
  target_group_arn = aws_lb_target_group.docker-prod-tg.arn
  target_id        = aws_instance.docker_prod.id
  port             = 8080
}

# creating docker load balancer
resource "aws_lb" "docker-prod-lb" {
  name               = "docker-prod-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.docker_prod_lb_sg]
  subnets            = [var.OAPAADpubsub1_id, var.OAPAADpubsub2_id]

  enable_deletion_protection = false


  tags = {
    Environment = "production"
  }
}
#creating load balancer listener
resource "aws_lb_listener" "docker-prod-listener" {
  load_balancer_arn = aws_lb.docker-prod-lb.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.docker-prod-tg.arn
  }
}




