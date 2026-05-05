# Fetches credentials from AWS Secrets Manager
data "aws_secretsmanager_secret" "okta_token" {
  name = "activecampaign/okta/api_key"
}

data "aws_secretsmanager_secret_version" "latest" {
  secret_id = data.aws_secretsmanager_secret.okta_token.id
}

# Use the secret to configure EC2 instances
resource "aws_instance" "ac_server" {
  count         = 2
  ami           = "ami-053b0d53c279acc90" #Ubuntu 22.04#
  instance_type = "t3.medium"

  user_data = <<-EOF
              #!/bin/bash
              echo "OKTA_TOKEN=${data.aws_secretsmanager_secret_version.latest.secret_string}" >> /etc/environment
              EOF

  tags = {
    Name = "ac-tech-app0${count.index + 1}"
  }
}
