data "aws_iam_policy_document" "appsync_stepfunctions_resolver" {
  statement {
    actions = [
      "states:DescribeExecution",
      "states:StopExecution",
    ]

    resources = [
      "*",
    ]

    sid = "DescribeStopExecutionStepFunctions"
  }
}