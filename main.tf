module "network" {
  source = "./modules/network"

  application = var.application
  aws_region  = var.aws_region
  environment = var.environment

  vpc_cidr_block = var.vpc_cidr_block
  public_zone    = var.public_zone
  private_zone   = var.private_zone
}
