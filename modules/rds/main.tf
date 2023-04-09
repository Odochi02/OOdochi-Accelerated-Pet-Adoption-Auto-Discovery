# #Create DB password
# resource "random_password" "db_password" {
#  length = 16
#  special = true
#  override_special = "!#$%&*()-_=+[]{}<>:?"
# }
# resource "random_id" "db_username" {
#  byte_length = 8
# }

# #create database subnet group
# resource "aws_db_subnet_group" "OAPAAD_dbsn_group" {
#   name       = "OAPAAD_dsn_group"
#   subnet_ids = var.OAPAADprvsub1_id, var.OAPAADprvsub2_id

#   tags = {
#     Name = "OAPAAD_dsn_group"
#   }
# }


# #Create MySQL RDS Instance
# resource "aws_db_instance" "OAPAAD_RDS" {
#  # identifier             = "OAPAAD_RDS"
#   storage_type           = "gp2"
#   allocated_storage      = 20
#   engine                 = "mysql"
#   engine_version         = "8.0"
#   instance_class         = "db.t2.micro"
#   port                   = "3306"
#   db_name                = "test"
#   username               = random_id.db_username.id
#   password               = random_password.db_password.result
#   multi_az               = true
#   parameter_group_name   = "default.mysql8.0"
#   deletion_protection    = false
#   skip_final_snapshot    = true
#   db_subnet_group_name   = aws_db_subnet_group.OAPAAD_dbsn_group.name
#   vpc_security_group_ids = [aws_security_group.OAPAAD_rds_sg.id]
# } 