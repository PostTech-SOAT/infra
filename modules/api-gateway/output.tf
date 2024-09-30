output "module" {
  value = [ for a in aws_api_gateway_resource.create_resource : a.id]
}