locals {
  api_name = "api-${var.application}-${var.api_gateway_configuration.api_type}"
}

resource "aws_api_gateway_rest_api" "api" {
  name                         = local.api_name
  api_key_source               = var.api_gateway_configuration.api_key_source
  disable_execute_api_endpoint = var.api_gateway_configuration.disable_execute_api_endpoint
  policy                       = var.api_gateway_configuration.api_gateway_policy

  endpoint_configuration {
    types            = [for values in var.api_gateway_configuration.api_endpoint_type : upper(values)]
    vpc_endpoint_ids = var.api_gateway_configuration.api_type == "private" ? var.api_gateway_vpc_endpoint_ids : null
  }

  tags = {
    Name = local.api_name
    Tier = "${var.api_gateway_configuration.api_type}"
  }
}

resource "aws_api_gateway_stage" "deploy_stage" {
  deployment_id = aws_api_gateway_deployment.deploy_api.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = var.api_gateway_configuration.deploy_api_stage_name
}

resource "aws_api_gateway_resource" "create_resource" {
  for_each = { for idx, config in var.api_gateway_endpoint_configuration : idx => config }

  path_part   = each.value.path_part
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.api.id

}

resource "aws_api_gateway_method" "method_request" {
  for_each = { for idx, config in var.api_gateway_endpoint_configuration : idx => config }

  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.create_resource[each.key].id
  http_method   = each.value.http_method
  authorization = each.value.authorization

  request_parameters = {
    "method.request.path.proxy" = each.value.is_method_path_proxy ? true : null
  }
}

resource "aws_api_gateway_integration" "integration_request" {
  for_each = { for idx, config in var.api_gateway_endpoint_configuration : idx => config }

  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.create_resource[each.key].id
  http_method             = aws_api_gateway_method.method_request[each.key].http_method
  integration_http_method = each.value.integration_http_method
  type                    = each.value.integration_type
  uri                     = each.value.is_lambda_trigger ? var.lambda_uri : each.value.is_ecs_endpoint ? "http://${var.loadbalancer_uri}:${each.value.port}/{proxy}" : ""
  passthrough_behavior    = each.value.passthrough_behavior

  request_parameters = {
    "integration.request.path.proxy"                                                     = each.value.path_part == "{proxy+}" ? "method.request.path.proxy" : null,
    (each.value.is_async_call ? "integration.request.header.X-Amz-Invocation-Type" : "") = (each.value.is_async_call ? "'Event'" : null)

  }
}

resource "aws_api_gateway_integration_response" "integration_response_200" {
  for_each = { for idx, config in var.api_gateway_endpoint_configuration : idx => config if !config.is_method_path_proxy }

  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.create_resource[each.key].id
  http_method = aws_api_gateway_method.method_request[each.key].http_method
  status_code = aws_api_gateway_method_response.response_200[each.key].status_code

  response_templates = {
    "application/json" = ""
  }
}

resource "aws_api_gateway_method_response" "response_200" {
  for_each = { for idx, config in var.api_gateway_endpoint_configuration : idx => config }

  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.create_resource[each.key].id
  http_method = aws_api_gateway_method.method_request[each.key].http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_deployment" "deploy_api" {

  rest_api_id = aws_api_gateway_rest_api.api.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_rest_api.api.body,
      aws_api_gateway_integration.integration_request
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_api_gateway_integration.integration_request]
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  for_each = { for idx, config in var.api_gateway_endpoint_configuration : idx => config if config.is_lambda_trigger }

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = "${each.value.lambda_name}-role"

}

resource "aws_lambda_permission" "apigw_lambda" {
  for_each = { for idx, config in var.api_gateway_endpoint_configuration : idx => config if config.is_lambda_trigger }

  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = each.value.lambda_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/${each.value.http_method}/${each.value.path_part}"

  depends_on = [aws_api_gateway_integration.integration_request]
}
