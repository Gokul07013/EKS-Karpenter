################################################################################
# Karpenter
################################################################################

# Configure AWS dependencies required for Karpenter to function
module "karpenter" {
  source = "terraform-aws-modules/eks/aws//modules/karpenter"

  cluster_name = module.eks.cluster_name

  node_iam_role_use_name_prefix   = false
  node_iam_role_name              = "karpenter"
  create_pod_identity_association = true

  tags = {
    Environment = "dev"
  }
}

################################################################################
# Karpenter Helm Release
################################################################################

# Install Karpenter Helm chart
resource "helm_release" "karpenter" {
  namespace = "kube-system"
  name      = "karpenter"

  repository          = "oci://public.ecr.aws/karpenter"
  repository_username = data.aws_ecrpublic_authorization_token.token.user_name
  repository_password = data.aws_ecrpublic_authorization_token.token.password
  chart               = "karpenter"
  version             = "1.6.0"

  wait = false

  values = [
    <<-EOT
    nodeSelector:
      karpenter.sh/controller: 'true'
    dnsPolicy: Default
    settings:
      clusterName: ${module.eks.cluster_name}
      clusterEndpoint: ${module.eks.cluster_endpoint}
      interruptionQueue: ${module.karpenter.queue_name}
      enableZonalShift: true
    webhook:
      enabled: false
    EOT
  ]
}