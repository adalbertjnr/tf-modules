# --- compute/main.tf --- #

data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "random_id" "random_ec2_id" {
  byte_length = 2
  count       = var.instance_count
  keepers = {
    key_name = var.key_name
  }
}

resource "aws_key_pair" "auth" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "instance" {
  count                  = var.instance_count
  instance_type          = var.instance_type
  ami                    = data.aws_ami.server_ami.id
  subnet_id              = var.public_subnets[count.index].id
  vpc_security_group_ids = [var.public_sg]
  key_name               = aws_key_pair.auth.key_name

  root_block_device {
    volume_size = var.root_vol_size
  }

  tags = {
    Name = "PROJ-INSTANCE-${random_id.random_ec2_id[count.index].dec}"
  }

  user_data = templatefile(var.userdata_path,
    {
      nodename    = "PROJ-INSTANCE-${random_id.random_ec2_id[count.index].dec}"
      db_user     = var.db_user
      db_pass     = var.db_pass
      db_name     = var.db_name
      db_endpoint = var.db_endpoint
    }
  )

}
