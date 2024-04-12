provider "aws" {
  region  = "us-east-1"
  profile = "tadeu"
}

module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "srv-02"

  ami                    = "ami-080e1f13689e07408"
  instance_type          = "t2.micro"
  key_name               = "srv01-password"
  monitoring             = true
  vpc_security_group_ids = ["sg-03498e962c32dabd3"]
  subnet_id              = "subnet-0f66903f9ba66883b"

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Autor       = "Tadeu_Terraform"
  }
}

module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "bia-dev"
  description = "acesso para o mundo"
  vpc_id      = "vpc-003c96e3b66c4bbd5"
  
  ingress_cidr_blocks = ["10.0.0.0/16"]
  ingress_with_cidr_blocks = [
    {

      from_port   = 3001
      to_port     = 3001
      protocol    = "tcp"
      description = "acesso do bia"
      cidr_blocks = "10.0.0.0/16"
      group-names = "bia-dev"
    },
  ]
}
