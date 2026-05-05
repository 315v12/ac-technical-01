############################################
# SECURITY GROUP
############################################

resource "aws_security_group" "this" {
  name        = "${var.name}-sg"
  description = "Security group for EC2 instances managed by Terraform"

  # SSH access (restrict this to YOUR IP in real use)
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_cidr_blocks
  }

  # HTTP (optional - remove if not needed)
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.http_cidr_blocks
  }

  # Outbound traffic (allow all)
  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

############################################
# EC2 INSTANCE
############################################

resource "aws_instance" "this" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.this.id]

  user_data = var.user_data

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-${count.index + 1}"
    }
  )
}
