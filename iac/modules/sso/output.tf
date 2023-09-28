output "user_pool_id" {
  value = aws_cognito_user_pool.pool.id
}


output "user_pool_arn" {
  value = aws_cognito_user_pool.pool.arn
}


output "user_pool_public_client_id" {
  value = aws_cognito_user_pool_client.pub_client.id
}


output "user_pool_private_client_id" {
  value = aws_cognito_user_pool_client.priv_client.id
}


output "user_pool_private_client_secret" {
  value = aws_cognito_user_pool_client.priv_client.client_secret
}