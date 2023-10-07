# --- database/main.tf --- #

resource "aws_db_instance" "db" {
  allocated_storage      = var.db_storage
  db_name                = var.db_name
  engine                 = "mysql"
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  db_subnet_group_name   = var.db_subnet_group_name
  username               = var.db_user
  password               = var.db_password
  identifier             = var.db_identifier
  vpc_security_group_ids = var.vpc_security_group_ids
  skip_final_snapshot    = var.skip_final_snapshot
  tags = {
    Name = "PROJ-RDS-DB"
  }
}
