# EKS with Karpenter Terraform Configuration

This Terraform configuration deploys an Amazon EKS cluster with Karpenter for autoscaling.

## Architecture

- **VPC**: Custom VPC with public and private subnets across 3 availability zones
- **EKS Cluster**: Kubernetes 1.35 cluster with managed node groups
- **Karpenter**: Installed for dynamic node provisioning
- **EBS CSI Driver**: Enabled with Pod Identity for persistent storage

## File Structure

```
.
├── provider.tf        # Terraform and provider configuration
├── variable.tf        # Input variables
├── locals.tf          # Local values
├── data.tf            # Data sources
├── vpc.tf             # VPC module configuration
├── eks.tf             # EKS cluster configuration
├── karpenter.tf       # Karpenter installation
├── pod-identity.tf    # EBS CSI Pod Identity configuration
└── outputs.tf         # Output values
```

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform >= 1.0
- kubectl (for cluster access)






