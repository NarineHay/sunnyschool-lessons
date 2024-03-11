resource "aws_instance" "web" {
  count = 3
  ami           = "ami-022661f8a4a1b91cf"
  instance_type = "t2.micro"

  tags = {
    Name = "MyEc2-${count.index+1}"
  }
}

