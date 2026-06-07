################################################################################
# General Variables
################################################################################

variable "project" {
  description = "Project name used for resource naming and tagging"
  type        = string
  default     = "multicloudcost"
}

variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

################################################################################
# VPC Variables
################################################################################

variable "cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "az" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

################################################################################
# EKS Variables
################################################################################

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "demo"
}

variable "k8s-version" {
  description = "Kubernetes version to use for the EKS cluster"
  type        = string
  default     = "1.35"
}

variable "endpoint_public_access" {
  description = "Enable public API server endpoint"
  type        = bool
  default     = true
}

variable "endpoint_private_access" {
  description = "Enable private API server endpoint"
  type        = bool
  default     = false
}

variable "node_pools" {
  description = "List of node pool names"
  type        = list(string)
  default     = ["general-purpose"]
}