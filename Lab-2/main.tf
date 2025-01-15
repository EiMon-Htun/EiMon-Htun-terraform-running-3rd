provider "aws" {
    region = "ap-southeast-1"
    profile = "default"
}

resource "aws_instance" "example" {
    ami = "ami-06650ca7ed78ff6fa"
    instance_type = "t2.micro"
    user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.xhtml
                nohup busybox httpd -f -p 8080 &
                EOF

user_data_replace_on_change = true

tags = {
Name = "terraform-example"
}
}