output "vpc" {
  value = aws_vpc.main
}

output "private_subnet" {
  value = {for a, b in aws_subnet.private_subnet : a=>b}
}

output "public_subnet" {
  value = {for a, b in aws_subnet.public_subnet : a=>b}
}