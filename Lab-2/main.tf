provider "aws" {
    region = "ap-southeast-1"
    profile = "default"
}

resource "aws_instance" "example" {
    ami = "ami-06650ca7ed78ff6fa"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.instance.id]
    user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p ${var.server_port} &
                EOF

user_data_replace_on_change = true

tags = {
Name = "terraform-example"
}
}

resource "aws_security_group" "instance" {
name = "terraform-example-instance"
ingress {
from_port = var.server_port
to_port = var.server_port
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

tags = {
    Name = "securitygroup_terraform"
}
}

output "Public_IP" {
  value = aws_instance.example.public_ip
}

output "vpc_security_group_ids" {
  value = aws_security_group.instance.id
}

variable "server_port" {
  description = "The Port the server will use for HTTP requests"
  type = number
  default = 8080
}