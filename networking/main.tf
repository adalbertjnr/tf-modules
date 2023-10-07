# --- networking/main.tf --- #

data "aws_availability_zones" "available" {}

resource "random_shuffle" "az" {
  input        = data.aws_availability_zones.available.names
  result_count = var.shuffleaz_max
}

resource "random_integer" "rd" {
  min = 1
  max = 20
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "AWSVPC-PROJ-${random_integer.rd.id}"
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = var.public_sn_count
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = random_shuffle.az.result[count.index]
  tags = {
    Name = "AWSPUB-SUBNET-PROJ-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = var.private_sn_count
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_cidrs[count.index]
  availability_zone = random_shuffle.az.result[count.index]

  tags = {
    Name = "AWSPRIV-SUBNET-PROJ-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "public_rtable" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "AWS-PUBLIC-RT"
  }
}

resource "aws_route_table_association" "public_rt_assc" {
  count          = var.public_sn_count
  subnet_id      = aws_subnet.public_subnets.*.id[count.index]
  route_table_id = aws_route_table.public_rtable.id
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rtable.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_default_route_table" "default_rtable" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  tags = {
    Name = "AWS-PRIV-RT"
  }
}

resource "aws_security_group" "sg" {
  for_each    = var.security_groups
  name        = each.value.name
  description = each.value.description
  vpc_id      = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_db_subnet_group" "rds_subnetgroup" {
  count      = var.db_subnet_group == true ? 1 : 0
  name       = "rds_subnet_group"
  subnet_ids = aws_subnet.private_subnets.*.id
  tags = {
    Name = "rds_subnet_group"
  }
}
