output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks_cluster.cluster_name
}

output "cluster_region" {
  description = "Region of the EKS cluster"
  value       = var.aws_region
}
