data "kubernetes_service" "ingress_nginx" {
  metadata {
    name      = var.ingress_nginx_service
    namespace = "kube-system"
  }
}
