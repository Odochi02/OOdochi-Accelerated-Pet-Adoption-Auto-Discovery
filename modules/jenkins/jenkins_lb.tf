# creating jenkins target group
resource "aws_lb_target_group" "OAPAAD-jenkins-tg" {
  name     = "OAPAAD-jenkins-tg"
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

#creating jenkins load balancer target group attachment
resource "aws_lb_target_group_attachment" "OAPAAD_jenkins_lb_tg_attachment" {
  target_group_arn = aws_lb_target_group.OAPAAD-jenkins-tg.arn
  target_id        = aws_instance.OAPAAD_jenkins.id
  port             = 8080
}

# creating jenkins load balancer
resource "aws_lb" "OAPAAD-jenkins-lb" {
  name               = "OAPAAD-jenkins-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.jenkins_lb_sg]
  subnets            = [var.OAPAADpubsub1_id, var.OAPAADpubsub2_id]

  enable_deletion_protection = false


  tags = {
    Environment = "production"
  }
}
#creating load balancer listener
resource "aws_lb_listener" "OAPAAD_listener" {
  load_balancer_arn = aws_lb.OAPAAD-jenkins-lb.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.OAPAAD-jenkins-tg.arn
  }
}
