module "appsync_stepfunctions_resolver" {
  dead_letter_arn = "${var.dead_letter_arn}"
  handler         = "function.handler"
  kms_key_arn     = "${var.kms_key_arn}"
  l3_object_key   = "quinovas/appsync-stepfunctions-resolver/appsync-stepfunctions-resolver-0.0.1.zip"
  name            = "${var.name_prefix}appsync-stepfunctions-resolver"

  policy_arns = [
    "${aws_iam_policy.appsync_stepfunctions_resolver.arn}",
  ]

  policy_arns_count = 1
  runtime           = "python3.7"
  source            = "QuiNovas/lambdalambdalambda/aws"
  timeout           = 30
  version           = "0.2.0"
}

resource "aws_iam_policy" "appsync_stepfunctions_resolver" {
  name   = "${var.name_prefix}appsync-stepfunctions-resolver"
  policy = "${data.aws_iam_policy_document.appsync_stepfunctions_resolver.json}"
}

module "appsync_lambda_datasource" {
  api_id                   = "${var.api_id}"
  invoke_lambda_policy_arn = "${module.appsync_stepfunctions_resolver.invoke_policy_arn}"
  lambda_function_arn      = "${module.appsync_stepfunctions_resolver.arn}"
  name                     = "${replace("${var.name_prefix}","-","_")}StepFunctionsResolver"
  source                   = "QuiNovas/appsync-lambda-datasource/aws"
  version                  = "1.0.1"
}
