
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = var.lambda_path
  output_path = "${var.lambda_path}/${basename(var.lambda_path)}.zip"
}

resource "aws_lambda_function" "lambda_func" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = var.lambdafunc_name
  role          = var.lambda_role_arn
  runtime       = var.lambda_runtime
  handler       = var.lambda_handler
}
