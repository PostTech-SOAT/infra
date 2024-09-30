##############################################################################
#                      GENERAL                                               #
##############################################################################

application = "hexburger"
environment = "dev"
aws_region  = "us-east-1"

##############################################################################
#                      NETWORK                                               #
##############################################################################

vpc_cidr_block = "10.200.0.0/24"
public_zone = {
  public_1a = {
    cidr_block        = "10.200.0.0/26"
    availability_zone = "a"
  },
  public_1c = {
    cidr_block        = "10.200.0.64/26"
    availability_zone = "c"
  }
}
private_zone = {
  private_1a = {
    cidr_block        = "10.200.0.128/26"
    availability_zone = "a"
  },
  private_1c = {
    cidr_block        = "10.200.0.192/26"
    availability_zone = "c"
  }
}

##############################################################################
#                      KUBERNETES                                            #
##############################################################################

auto_scale_options = {
  min     = 2
  max     = 3
  desired = 2
}
cluster_name          = "hexburger-eks-cluster"
aws_account_id        = "169299837592"
cluster_version       = "1.30"
nodes_instances_sizes = ["t3.medium"]

eks_addons = [
  {
    name    = "aws-ebs-csi-driver"
    version = "v1.30.0-eksbuild.1"
  }
]

##############################################################################
#                      NGINX                                                 #
##############################################################################
ingress_nginx_name = "ingress-nginx"


##############################################################################
#                      API GATEWAY                                           #
##############################################################################
ingress_nginx_service = "ingress-nginx-controller"

api_gateway_configuration = {
  api_type                       = "public"
  api_endpoint_type              = ["edge"]
  api_key_source                 = null
  disable_execute_api_endpoint   = false
  api_gateway_policy             = null
  deploy_api_stage_name          = "deploy"
  is_there_authorizer            = true
}

api_gateway_endpoint_configuration = [{
  create_apigateway_resource = true
  path_part                  = "criar-cliente"
  method_endpoint_configuration = [{
    lambda_name                = "CriarClienteCognito"
    is_lambda_trigger          = true
    is_ecs_endpoint            = false
    is_method_path_proxy       = true
    is_async_call              = false
    create_apigateway_resource = true
    http_method                = "POST"
    authorization              = "NONE"
    integration_http_method    = "POST"
    integration_type           = "AWS_PROXY"
    passthrough_behavior       = "WHEN_NO_TEMPLATES"
    uri                        = ""
    port                       = ""
  }]
  }, {
  create_apigateway_resource = true
  path_part                  = "pedido"
  method_endpoint_configuration = [{
    lambda_name                = ""
    is_method_path_proxy       = true
    is_ecs_endpoint            = true
    is_lambda_trigger          = false
    is_async_call              = false
    app_endpoint_path          = "v1/pedido"
    http_method                = "POST"
    authorization              = "NONE"
    integration_http_method    = "POST"
    integration_type           = "HTTP_PROXY"
    passthrough_behavior       = "WHEN_NO_TEMPLATES"
    uri                        = ""
    port                       = ""
  },
  {
    lambda_name                = ""
    is_method_path_proxy       = false
    is_ecs_endpoint            = true
    is_lambda_trigger          = false
    is_async_call              = false
    app_endpoint_path          = "v1/pedido"
    http_method                = "GET"
    authorization              = "NONE"
    integration_http_method    = "GET"
    integration_type           = "HTTP_PROXY"
    passthrough_behavior       = "WHEN_NO_TEMPLATES"
    uri                        = ""
    port                       = ""
  }]
  },]
