resource "aws_s3_bucket" "bucket" {
  for_each = var.users
  bucket   = trim(each.value.HomeDirectory, "/")

  tags = try(each.value.Tags, null)
}

resource "aws_s3_bucket_acl" "bucket" {
  for_each = aws_s3_bucket.bucket
  bucket   = each.value.id
  acl      = "private"
}

resource "aws_transfer_server" "transfer_server" {
  identity_provider_type = "SERVICE_MANAGED"

  tags = {
    NAME = var.name
  }
}

resource "aws_transfer_user" "transfer_server_user" {
  for_each = var.users

  server_id = aws_transfer_server.transfer_server.id
  user_name = each.key
  role      = aws_iam_role.s3_access_for_sftp_users[each.key].arn

  home_directory = trimsuffix(each.value.HomeDirectory, "/")

  tags = try(each.value.Tags, null)
}

resource "aws_transfer_ssh_key" "transfer_server_ssh_key" {
  for_each = var.users

  server_id = aws_transfer_server.transfer_server.id
  user_name = aws_transfer_user.transfer_server_user[each.key].user_name

  body = try(each.value.PublicKey, {})
}
