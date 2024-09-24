variable "application" {
  description = "Nome da aplicação usada para interpolar nomes de recursos e variavel environment"
  type        = string
}

variable "aws_region" {
  description = "Região AWS que será deployado os recursos"
  type        = string
}

variable "environment" {
  description = "Ambiente de deploy da aplicação. Usado para interpolar nomes junto com variavel application"
  type        = string
}

variable "vpc_cidr_block" {
  description = "Define o bloco de rede alocado ao projeto"
  type        = string
}

variable "public_zone" {
  description = "Define os blocos de rede publicos alocados ao projeto"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "private_zone" {
  description = "Define os blocos de rede privados alocados ao projeto"
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
}

variable "cluster_name" {}
variable "cluster_role_arn" {}
variable "cluster_version" {}
variable "nodes_instances_sizes" {}
variable "auto_scale_options" {}
variable "ingress_nginx_name" {}