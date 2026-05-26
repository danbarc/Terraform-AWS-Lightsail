# ses.tf
resource "aws_iam_user" "ses_smtp" {
  name = "wordpress-ses-smtp"
}

resource "aws_iam_user_policy" "ses_smtp" {
  user = aws_iam_user.ses_smtp.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["ses:SendEmail", "ses:SendRawEmail"]
      Resource = "*"
    }]
  })
}

resource "aws_iam_access_key" "ses_smtp" {
  user = aws_iam_user.ses_smtp.name
}

output "ses_smtp_username" {
  value = aws_iam_access_key.ses_smtp.id
}

output "ses_smtp_password" {
  value     = aws_iam_access_key.ses_smtp.ses_smtp_password_v4
  sensitive = true
}
