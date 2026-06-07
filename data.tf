################################################################################
# Data Sources
################################################################################

# To authenticate ECR public registry to pull Karpenter images
data "aws_ecrpublic_authorization_token" "token" {
  region = "us-east-1"
}
