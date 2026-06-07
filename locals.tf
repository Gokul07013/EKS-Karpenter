################################################################################
# Local Values
################################################################################

locals {
  name = var.cluster_name

  tags = {
    Environment = var.environment
    Project     = var.project
  }
}
