variable "cluster_name" {
  type = string
  default = "Online_Boutique2"
}

variable "cluster_version" {
  type = number
  default = 1.29
}

variable "region" {
  type = string
  default = "ca-central-1"
}

variable "availability_zones" {
  type = list
  default = ["ca-central-1a", "ca-central-1b"]
}
variable "eks_admins_iam_role_arn" {
  description = "ARN of the IAM role for EKS administrators"
}

variable "eks_admins_iam_role_name" {
  description = "Name of the IAM role for EKS administrators"
}



variable "addons" {
  type = list(object({
    name    = string
    version = string
  }))

  default = [
    {
      name    = "kube-proxy"
      version = "v1.25.6-eksbuild.1"
    },
    {
      name    = "vpc-cni"
      version = "v1.12.2-eksbuild.1"
    },
    {
      name    = "coredns"
      version = "v1.9.3-eksbuild.2"
    },
    {
      name    = "aws-ebs-csi-driver"
      version = "v1.23.0-eksbuild.1"
    }
  ]
}