locals {
  name = format("MyEc %s 2", "-")
}


resource "aws_launch_template" "Ec2Template" {
  name = "Ec2Template"  
  image_id = "ami-0e0bf53f6def86294"  
  instance_type = var.inst_type 
  

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = local.name
    }
  }

  user_data = filebase64("userdata.tpl")
}

resource "aws_instance" "web" {
  count = 3
  ami           = "ami-022661f8a4a1b91cf"
  instance_type = var.inst_type

  tags = {
    Name = "MyEc2-${formatdate("DD-MM-YYYY", timestamp())}-${count.index+1}"
  }

  launch_template {
    id      = aws_launch_template.Ec2Template.id
    version = "1"
  }

}

output "private_ip_addresses" {
  value = aws_instance.web[*].private_ip
}