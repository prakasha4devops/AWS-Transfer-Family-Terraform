data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["transfer.amazonaws.com"]
    }

  }
}

data "aws_iam_policy_document" "s3_access_for_sftp_users" {
  for_each = var.users

  statement {
    effect = "Allow"

    actions = try(each.value.ReadOnly, null) == null ? [
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:ListBucket",
      "s3:PutObject",
      ] : [
      "s3:GetObject"
    ]


    resources = [
      "arn:aws:s3:::${trim(each.value.HomeDirectory, "/")}",
      "arn:aws:s3:::${trim(each.value.HomeDirectory, "/")}/*"
    ]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = try(each.value.AllowFrom, null)
    }
  }
}

resource "aws_iam_policy" "s3_access_for_sftp_users" {
  for_each = var.users
  name     = "${each.key}-transfer_server_policy"
  policy   = data.aws_iam_policy_document.s3_access_for_sftp_users[each.key].json
}

resource "aws_iam_role" "s3_access_for_sftp_users" {
  for_each            = var.users
  name                = "${each.key}-s3-access-for-sftp"
  assume_role_policy  = data.aws_iam_policy_document.assume_role_policy.json
  managed_policy_arns = [aws_iam_policy.s3_access_for_sftp_users[each.key].arn]
}