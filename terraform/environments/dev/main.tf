############################################
# PROVIDER
############################################

provider "aws" {
  region = "us-east-1"
}

############################################
# SECRETS MANAGER (OKTA TOKEN)
############################################

data "aws_secretsmanager_secret" "okta_token" {
  name = "activecampaign/okta/api_key"
}

data "aws_secretsmanager_secret_version" "latest" {
  secret_id = data.aws_secretsmanager_secret.okta_token.id
}

############################################
# EC2 MODULE
############################################

module "ec2" {
  source = "../../modules/ec2"

  name           = "ac-tech-app"
  ami            = "ami-053b0d53c279acc90"
  instance_type  = "t3.micro"
  instance_count = 2

  # Inject secret into user_data
  user_data = <<-EOF
    #!/bin/bash
    echo "OKTA_TOKEN=${data.aws_secretsmanager_secret_version.latest.secret_string}" >> /etc/environment
  EOF

  # SECURITY GROUP RULES
  ssh_cidr_blocks  = ["74.70.230.200/32"]
  http_cidr_blocks = ["0.0.0.0/0"]

  tags = {
    Env = "dev"
  }
}

############################################
# OUTPUTS
############################################

output "instance_ids" {
  value = module.ec2.instance_ids
}

output "instance_ips" {
  value = module.ec2.instance_ips
}

output "instance_dns" {
  value = module.ec2.instance_dns
}
