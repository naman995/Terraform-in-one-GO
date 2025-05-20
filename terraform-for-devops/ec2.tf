# Key pair (login)
resource "aws_key_pair" "deployer" {
  key_name   = "terra-key-ec2"
  public_key = file("terra-key-ec2.pub")
}

# VPC and security Group 
resource "aws_default_vpc" "default" {

}
# resource "" "name" {

# }

resource "aws_security_group" "my_security_group" {
  name        = "automated-sg"
  description = "This is Terraform Generated Secutity grp"
  vpc_id      = aws_default_vpc.default.id #Interpolation ( Interpolation in Terraform means embedding variables, resource attributes,
  #    or expressions inside strings—so Terraform can evaluate and substitute them dynamically.)


  #   Inbound Rules Ingress
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All access open outbound"
  }
  tags = {
    Name = "automated-sg"
  }

  # Outbound Rule Egress
}
# EC2 instance
resource "aws_instance" "my_instance" {
  key_name        = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.my_security_group.name]
  instance_type   = var.ec2_instance_type #"t2.micro"
  ami             = var.ec2_ami_id        #"ami-04f167a56786e4b09"
  user_data       = file("install_nginx.sh")
  root_block_device {
    volume_size = 15
    volume_type = "gp3"

  }
  tags = {
    Name = "Terraform-automate"
  }
}
