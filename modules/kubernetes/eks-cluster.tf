resource "aws_eks_cluster" "hexburger_eks_cluster" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids = concat(var.public_subnet_ids, var.private_subnet_ids)
  }

  tags = {
    Name = var.cluster_name
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    labels = {
      name = "api"
    }
    name = "api"
  }
}