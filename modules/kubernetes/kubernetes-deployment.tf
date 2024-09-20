provider "kubernetes" {
  host                   = aws_eks_cluster.hexburger_eks_cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.hexburger_eks_cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.hexburger_eks_cluster.token
}

data "aws_eks_cluster_auth" "hexburger_eks_cluster" {
  name = aws_eks_cluster.hexburger_eks_cluster.name
}

resource "kubernetes_deployment" "hexburger_deployment" {
  metadata {
    name = "hexburger-deployment"
    labels = {
      app = "hexburger"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "hexburger"
      }
    }

    template {
      metadata {
        labels = {
          app = "hexburger"
        }
      }

      spec {
        container {
          name  = "hexburger"
          image = "guirodriguero/hexburger:latest" #ARN do ECR
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}