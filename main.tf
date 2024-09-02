terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.10.0"
    }
  }
}
#Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

#Create EC2 Instance
resource "aws_instance" "jenkins-ec2" {
  ami                       = "ami-066784287e358dad1"
  instance_type             = "t3.medium"
  security_groups = [aws_security_group.myjenkins_sg.name]
  #user_data                 = file("install_jenkins.sh")
 
  tags = {
    Name = "jenkins-ec2"
 }
} 
#Create security group 
resource "aws_security_group" "myjenkins_sg" {
  name        = "allow_http"
  description = "Allow inbound ports 22, 8080"
  vpc_id      =  "vpc-0ecd029158c6d24b4"


  #Allow incoming TCP requests on port 22 from any IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
#Allow incoming TCP requests on port 443 from any IP
  ingress {
    description = "Allow HTTPS Traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Allow incoming TCP requests on port 8080 from any IP
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Allow all outbound requests
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  tags = {
    Name = "ec2_sg"
  }
}

#Create S3 bucket for Jenksin Artifacts
resource "aws_s3_bucket" "my-s3-Jenkins" {
  bucket = "jenkins-s3-bucket-my"

  tags = {
    Name = "Jenkins-Server"
  }
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = aws_s3_bucket.my-s3-Jenkins.id
  acl    = "private"
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

# Resource to avoid error "AccessControlListNotSupported: The bucket does not allow ACLs"
resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.my-s3-Jenkins.id
  rule {
    object_ownership = "ObjectWriter"
  }
 }
