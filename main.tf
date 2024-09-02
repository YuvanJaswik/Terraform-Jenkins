provider "aws" {
    region = "us-east-1"  
}

resource "aws_instance" "foo" {
  ami           = "ami-066784287e358dad1"
  instance_type = "t3.medium"
  tags = {
      Name = "TF-Instance"
  }
}
