output "access_key_id" {
  value = aws_iam_access_key.github_access_key.id
}

output "secret_access_key" {
  value     = aws_iam_access_key.github_access_key.secret
  sensitive = true
}

output "bucket_name" {
  value = aws_s3_bucket.bucket.bucket
}
