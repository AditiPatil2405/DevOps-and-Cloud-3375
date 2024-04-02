module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"
  name = "main"
  cidr = "10.0.0.0/16"
  azs             = var.availability_zones
  private_subnets = ["10.0.0.0/19", "10.0.32.0/19"]
  public_subnets  = ["10.0.64.0/19", "10.0.96.0/19"]
  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  enable_dns_hostnames = true
  enable_dns_support   = true
}
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.29.0"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  enable_irsa = true
  eks_managed_node_group_defaults = {
    disk_size = 50
  }
  eks_managed_node_groups = {
    eks_boutique = {
      desired_size = 3
      min_size     = 3
      max_size     = 4
      labels = {
        role = "general"
      }
      instance_types = ["t2.large"]
      capacity_type  = "ON_DEMAND"
    }
  }
  node_security_group_additional_rules = {
    ingress_allow_access_from_control_plane = {
      type                          = "ingress"
      protocol                      = "tcp"
      from_port                     = 9443
      to_port                       = 9443
      source_cluster_security_group = true
      description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
    }
  }
  tags = {
    Environment = "dev"
  }
}

data "aws_eks_cluster" "default" {
  name = module.eks.cluster_id
}
data "aws_eks_cluster_auth" "default" {
  name = module.eks.cluster_id
}
provider "kubernetes" {
  host                   = data.aws_eks_cluster.default.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
  # token                  = data.aws_eks_cluster_auth.default.token
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.default.id]
    command     = "aws"
  }
}