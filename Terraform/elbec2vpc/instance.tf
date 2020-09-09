provider "aws" {
    region = var.aws_region
}

# Lookup the correct AMI based on the region specified
#aws ec2 describe-images --region us-east-1 --image-ids ami-xxxxxx
data "aws_ami" "Canonical_ubuntu18" {
  most_recent       = true
   owners           = ["099720109477"] # Canonical

  filter {
    name            = "name"
    values          = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

resource "aws_instance" "web01" {
  ami                    = data.aws_ami.Canonical_ubuntu18.image_id
  key_name 	             = aws_key_pair.mykey.key_name
  user_data              = data.template_file.user_data.rendered
  vpc_security_group_ids = [aws_security_group.myterra-sg.id]
  subnet_id              = aws_subnet.terra-pub-1.id
  instance_type           = "t2.micro"

tags = {
    Name 	= "web01"
    }


# The connection block tells our provisioner how to
# communicate with the resource (instance)
  connection {
    type                = "ssh"
    user                = var.username
    private_key         = file(var.priv_key)
    host                = self.public_ip

  }
}

resource "aws_instance" "web02" {
  ami                    = data.aws_ami.Canonical_ubuntu18.image_id
  key_name 	             = aws_key_pair.mykey.key_name
  user_data              = data.template_file.user_data.rendered
  vpc_security_group_ids = [aws_security_group.myterra-sg.id]
  subnet_id              = aws_subnet.terra-pub-2.id
  instance_type           = "t2.micro"

tags = {
    Name 	= "web02"
    }


# The connection block tells our provisioner how to
# communicate with the resource (instance)
  connection {
    type                = "ssh"
    user                = var.username
    private_key         = file(var.priv_key)
    host                = self.public_ip

  }
}

data "template_file" "user_data" {
 template               = file("templates/user_data.tpl")
}
