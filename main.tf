provider "aws" {
    region = "us-east-1"
}

resource "aws_security_group" "jay_aws-security_group" {
  name = "jay-terraform-asg"
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   tags = {
      user = "jay"
      createdby = "tf"
  }
}

resource "aws_instance" "jay_aws_ami_example" {
  ami = "ami-017e2de67926d7a27"
  subnet_id = "subnet-543edf19"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.jay_aws-security_group.id]

  tags = {
      user = "jay"
      createdby = "tf"
  }
}

output "public_ip" {
  value = aws_instance.jay_aws_ami_example.public_ip
  description = "The public IP of the Web Server"
}