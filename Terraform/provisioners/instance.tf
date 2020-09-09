provider "aws" {
    region = var.aws_region
}

resource "aws_key_pair" "mykey"{
  key_name = "mykey"
  public_key = file(var.pub_key)
}

resource "aws_instance" "pluto" {
  ami 		= var.amiid
  instance_type = "t2.micro"
  key_name 	= aws_key_pair.mykey.key_name

tags = {
    Name 	= "web01"
    }

  provisioner "file" {
    source	 = "websetup.sh"
    destination  = "/tmp/websetup.sh"
  }

  provisioner "remote-exec" {
    inline = [
     	"chmod +x /tmp/websetup.sh",
     	"sudo /tmp/websetup.sh"
    ]
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
