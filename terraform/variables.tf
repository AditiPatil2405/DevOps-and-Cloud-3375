variable "aws_region" {
  type        = string
  description = "The AWS region to apply this config to"
}

variable "eks_cluster_name" {
  type        = string
  description = "Name given to the new EKS cluster"
  default     = "online-boutique"
}

variable "eks_cluster_version" {
  type        = string
  description = "The Kubernetes version to use for the EKS cluster"
  default     = "1.21"  # Choose the desired version
}

variable "eks_cluster_node_group_name" {
  type        = string
  description = "Name given to the EKS node group"
  default     = "eks-nodes"
}

variable "eks_cluster_node_group_desired_capacity" {
  type        = number
  description = "Desired number of nodes in the EKS node group"
  default     = 2
}

variable "eks_cluster_node_group_max_capacity" {
  type        = number
  description = "Maximum number of nodes in the EKS node group"
  default     = 2
}

variable "eks_cluster_node_group_min_capacity" {
  type        = number
  description = "Minimum number of nodes in the EKS node group"
  default     = 1
}

variable "eks_cluster_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs where the EKS cluster will be deployed"
  # Update with your subnet IDs
  default     = ["subnet-xxxxxxxxxxxxxx", "subnet-yyyyyyyyyyyyyy", "subnet-zzzzzzzzzzzzzz"]
}

variable "eks_cluster_vpc_id" {
  type        = string
  description = "VPC ID where the EKS cluster will be deployed"
  # Update with your VPC ID
  default     = "vpc-xxxxxxxxxxxxxxxx"
}

variable "kubernetes_manifests_directory" {
  type        = string
  description = "Path to Online Boutique's Kubernetes resources, written using Kustomize"
  default     = "../kustomize/"
}

variable "enable_memorystore" {
  type        = bool
  description = "If true, Online Boutique's in-cluster Redis cache will be replaced with an AWS ElastiCache Redis cache"
}
