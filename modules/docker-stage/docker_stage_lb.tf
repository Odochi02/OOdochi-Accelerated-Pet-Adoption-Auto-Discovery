# creating docker target group
resource "aws_lb_target_group" "docker-stage-tg" {
  name     = "docker-stage-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30

  }
}

#creating docker stage load balancer target group attachment
resource "aws_lb_target_group_attachment" "docker-stage_tg_attachment" {
  target_group_arn = aws_lb_target_group.docker-stage-tg.arn
  target_id        = aws_instance.docker_stage.id
  port             = 8080
}

# creating docker load balancer
resource "aws_lb" "docker-stage-lb" {
  name               = "docker-stage-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.docker-stage_sg]
  subnets            = [var.OAPAADpubsub1_id, var.OAPAADpubsub2_id]

  enable_deletion_protection = false


  tags = {
    Environment = "stageuction"
  }
}
#creating load balancer listener
resource "aws_lb_listener" "docker-stage-listener" {
  load_balancer_arn = aws_lb.docker-stage-lb.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.docker-stage-tg.arn
  }
}



