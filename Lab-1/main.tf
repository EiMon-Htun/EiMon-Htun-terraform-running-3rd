provider "aws" {
    region = "ap-southeast-1"
    profile = "default"
}

resource "aws_instance" "example" {
ami = "ami-06650ca7ed78ff6fa"
instance_type = "t2.micro"

tags = {
  Name = "my1ststance"
}
}