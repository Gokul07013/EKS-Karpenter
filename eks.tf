################################################################################
# EKS Cluster
################################################################################

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.22.0"

  name               = var.cluster_name
  kubernetes_version = var.k8s-version

  endpoint_public_access  = var.endpoint_public_access
  endpoint_private_access = var.endpoint_private_access

  enable_cluster_creator_admin_permissions = true

  compute_config = {
    enabled = false
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.public_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  ################################################################################
  # EKS Addons
  ################################################################################

  addons = {
    coredns = {}

    eks-pod-identity-agent = {
      before_compute = true
    }

    kube-proxy = {}

    vpc-cni = {
      before_compute = true
    }

    aws-ebs-csi-driver = {}
  }

  ################################################################################
  # EKS Managed Node Groups
  ################################################################################

  eks_managed_node_groups = {
    karpenter = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 2
      desired_size = 1

      labels = {
        "karpenter.sh/controller" = "true"
      }
    }
  }

  # Tagging resources for Karpenter discovery
  node_security_group_tags = {
    "karpenter.sh/discovery" = "karpenter"
  }

  tags = {
    Environment = var.environment
  }
}