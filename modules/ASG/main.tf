#Add High Availability

# Create Docker_Host AMI Image
resource "aws_ami_from_instance" "OAPAAD_AMI" {
  name                    = "OAPAAD_AMI"
  source_instance_id      = var.source_instance_id

  depends_on = [
    var.docker_instance
  ]

  tags = {
    Name = "OAPAAD_AMI"
  }
}


#Create launch template
resource "aws_launch_template" "OAPAAD-lt" {
  name_prefix                 = "OAPAAD-lt"
  image_id                    = var.ami_redhat
  instance_type               = var.instance_type

  key_name                    = var.keypair

  monitoring {
    enabled = false
}

  network_interfaces{
  associate_public_ip_address = true
  security_groups             = [var.docker-prod_sg]
  }

}

# Create Autoscaling group
resource "aws_autoscaling_group" "OAPAAD-asg" {
  name                      = "OAPAAD-asg"
  
  max_size                  = 3
  min_size                  = 2
  health_check_grace_period = 300
  default_cooldown          = 60
  health_check_type         = "EC2"
  desired_capacity          = 2
  force_delete              = true
  vpc_zone_identifier       = var.OAPAADpubsub1_id
  target_group_arns         = [var.OAPAAD-tgarn]
 
launch_template {
    id                      = aws_launch_template.OAPAAD-lt.id
    version                 = "$Latest"
}

tag {
    key                 = "Name"
    value               = "OAPAAD-asg"
    propagate_at_launch = true
  }
}

# create Autoscaling group policy
resource "aws_autoscaling_policy" "OAPAAD-asg-pol" {
  name                   = "OAPAAD-asg-pol"
  policy_type            = "TargetTrackingScaling"
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.OAPAAD-asg.name
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 40
  }
}
