output "instance_id" {
  value = aws_instance.pluto.*.id

}

output "public_ip" {
  value = aws_instance.pluto.*.public_ip

}

output "private_ip" {
  value = aws_instance.pluto.*.private_ip

}

