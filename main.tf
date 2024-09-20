module "network" {
  source = "./modules/network"

  application = var.application
  aws_region  = var.aws_region
  environment = var.environment

  vpc_cidr_block = var.vpc_cidr_block
  public_zone    = var.public_zone
  private_zone   = var.private_zone
}

module "kubernetes" {
  source = "./modules/kubernetes"

  public_subnet_ids     = module.network.public_subnet_ids
  private_subnet_ids    = module.network.private_subnet_ids
  auto_scale_options    = var.auto_scale_options
  cluster_name          = var.cluster_name
  cluster_role_arn      = var.cluster_role_arn
  cluster_version       = var.cluster_version
  nodes_instances_sizes = var.nodes_instances_sizes
}

module "container" {
  source = "./modules/container"

  application = var.application
}

module "nginx" {
  source = "./modules/nginx"

  ingress_nginx_name = var.ingress_nginx_name
}