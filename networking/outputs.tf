output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "db_subnet_group_name_otp" {
  value = aws_db_subnet_group.rds_subnetgroup.*.name
}

output "db_security_group_otp" {
  value = aws_security_group.sg
}

