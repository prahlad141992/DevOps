output "web01_instance_id" {
  value = aws_instance.web01.*.id

}

output "web02_instance_id" {
  value = aws_instance.web01.*.id

}

output "web01_private_ip" {
  value = aws_instance.web01.*.private_ip

}

output "web02_private_ip" {
  value = aws_instance.web01.*.private_ip

}

output "web01_public_ip" {
  value = aws_instance.web01.*.public_ip

}

output "web02_public_ip" {
  value = aws_instance.web01.*.public_ip

}

output "ELB_FQDN" {
  value = "${aws_elb.webelb.dns_name}"
}



