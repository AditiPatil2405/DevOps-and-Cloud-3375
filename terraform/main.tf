provider "aws" {
  region = "ca-central-1"
}

locals {
  eks_cluster_name = "my_cluster"
}



# Create EKS Cluster
module "eks_cluster" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = local.eks_cluster_name
  subnets         = ["subnet-xxxxxxxxxxxxxx", "subnet-yyyyyyyyyyyyyy"]# Update with your subnet IDs
  vpc_id          = "vpc-08a5775fdb38b9a62" # Update with your VPC ID
  node_groups     = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 2
      min_capacity     = 1
    }
  }
}

# Execute AWS CLI command to get EKS cluster credentials
resource "null_resource" "get_eks_credentials" {
  provisioner "local-exec" {
    command = <<-EOT
      aws eks --region your_aws_region update-kubeconfig --name ${local.eks_cluster_name}
    EOT
  }

  depends_on = [
    module.eks_cluster,
    module.enable_aws_apis
  ]
}

# Apply Kubernetes manifest configurations
resource "null_resource" "apply_deployment" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = "kubectl apply -f ${path.module}/your_kubernetes_manifests_directory -n your_namespace"
  }

  depends_on = [
    null_resource.get_eks_credentials
  ]
}

# Wait condition for all Pods to be ready before finishing
resource "null_resource" "wait_conditions" {
  provisioner "local-exec" {
    interpreter = ["bash", "-exc"]
    command     = <<-EOT
      kubectl wait --for=condition=READY pods --all -n your_namespace --timeout=280s
    EOT
  }

  depends_on = [
    null_resource.apply_deployment
  ]
}
