api_gateway_endpoint_configuration = [{
  create_apigateway_resource = true
  is_there_path_parent       = false
  path_parent                = ""
  path_part                  = "cliente"
  child_path                 = ""
  method_endpoint_configuration = [{
    lambda_name             = ""
    is_method_path_proxy    = false
    proxy_path              = ""
    is_ecs_endpoint         = true
    is_lambda_trigger       = false
    is_async_call           = false
    app_endpoint_path       = "v1/cliente"
    http_method             = "POST"
    authorization           = "NONE"
    is_there_authorization  = false
    authorization_name      = ""
    integration_http_method = "POST"
    integration_type        = "HTTP_PROXY"
    passthrough_behavior    = "WHEN_NO_TEMPLATES"
    uri                     = ""
    port                    = ""
  }]
  }, {
  create_apigateway_resource = true
  is_there_path_parent       = true
  path_parent                = "cliente"
  path_part                  = "{cpf+}"
  child_path                 = "{cpf+}"
  method_endpoint_configuration = [{
    lambda_name             = ""
    is_method_path_proxy    = true
    proxy_path              = "cpf"
    is_ecs_endpoint         = true
    is_lambda_trigger       = false
    is_async_call           = false
    app_endpoint_path       = "v1/cliente/{cpf}"
    http_method             = "ANY"
    authorization           = "NONE"
    is_there_authorization  = false
    authorization_name      = ""
    integration_http_method = "GET"
    integration_type        = "HTTP_PROXY"
    passthrough_behavior    = "WHEN_NO_TEMPLATES"
    uri                     = ""
    port                    = ""
  }]
  } /*, {
  create_apigateway_resource = true
  is_there_path_parent       = false
  path_parent                = ""
  path_part                  = "pedido"
  method_endpoint_configuration = [{
    lambda_name             = ""
    is_method_path_proxy    = true
    is_ecs_endpoint         = true
    is_lambda_trigger       = false
    is_async_call           = false
    app_endpoint_path       = "v1/pedido"
    http_method             = "POST"
    authorization           = "CUSTOM"
    is_there_authorization  = true
    authorization_name      = "BuscarClienteCognito"
    integration_http_method = "POST"
    integration_type        = "HTTP_PROXY"
    passthrough_behavior    = "WHEN_NO_TEMPLATES"
    uri                     = ""
    port                    = ""
    },
    {
      lambda_name             = ""
      is_method_path_proxy    = false
      is_ecs_endpoint         = true
      is_lambda_trigger       = false
      is_async_call           = false
      app_endpoint_path       = "v1/pedido"
      http_method             = "GET"
      authorization           = "CUSTOM"
      is_there_authorization  = true
      authorization_name      = "BuscarAdminCognito"
      integration_http_method = "GET"
      integration_type        = "HTTP_PROXY"
      passthrough_behavior    = "WHEN_NO_TEMPLATES"
      uri                     = ""
      port                    = ""
  }]
  },
  {
    create_apigateway_resource = true
    is_there_path_parent       = true
    path_parent                = "pedido"
    path_part                  = "{id}"
    child_path                 = "{id}"
    method_endpoint_configuration = [{
      lambda_name             = ""
      is_method_path_proxy    = true
      is_ecs_endpoint         = true
      is_lambda_trigger       = false
      is_async_call           = false
      app_endpoint_path       = "v1/pedido/status/{id}"
      http_method             = "GET"
      authorization           = "CUSTOM"
      is_there_authorization  = true
      authorization_name      = "BuscarClienteCognito"
      integration_http_method = "POST"
      integration_type        = "HTTP_PROXY"
      passthrough_behavior    = "WHEN_NO_TEMPLATES"
      uri                     = ""
      port                    = ""
    }]
  },
  {
    create_apigateway_resource = true
    is_there_path_parent       = false
    path_parent                = ""
    path_part                  = "produto"
    method_endpoint_configuration = [{
      lambda_name             = ""
      is_method_path_proxy    = true
      is_ecs_endpoint         = true
      is_lambda_trigger       = false
      is_async_call           = false
      app_endpoint_path       = "v1/produto"
      http_method             = "POST"
      authorization           = "CUSTOM"
      is_there_authorization  = true
      authorization_name      = "BuscarAdminCognito"
      integration_http_method = "POST"
      integration_type        = "HTTP_PROXY"
      passthrough_behavior    = "WHEN_NO_TEMPLATES"
      uri                     = ""
      port                    = ""
    }]
  },
  {
    create_apigateway_resource = true
    is_there_path_parent       = true
    path_parent                = "produto"
    path_part                  = "{pid}"
    child_path                 = "{pid}"
    method_endpoint_configuration = [{
      lambda_name             = ""
      is_method_path_proxy    = true
      is_ecs_endpoint         = true
      is_lambda_trigger       = false
      is_async_call           = false
      app_endpoint_path       = "v1/produto/{id}"
      http_method             = "PUT"
      authorization           = "CUSTOM"
      is_there_authorization  = true
      authorization_name      = "BuscarAdminCognito"
      integration_http_method = "PUT"
      integration_type        = "HTTP_PROXY"
      passthrough_behavior    = "WHEN_NO_TEMPLATES"
      uri                     = ""
      port                    = ""
      }, {
      lambda_name             = ""
      is_method_path_proxy    = true
      is_ecs_endpoint         = true
      is_lambda_trigger       = false
      is_async_call           = false
      app_endpoint_path       = "v1/produto/{id}"
      http_method             = "DELETE"
      authorization           = "CUSTOM"
      is_there_authorization  = true
      authorization_name      = "BuscarAdminCognito"
      integration_http_method = "DELETE"
      integration_type        = "HTTP_PROXY"
      passthrough_behavior    = "WHEN_NO_TEMPLATES"
      uri                     = ""
      port                    = ""
    }]
  }*/

]
