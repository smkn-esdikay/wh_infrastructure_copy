terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.50.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region  = "us-east-1"
  profile = "pintv-development-infra"
}

data "aws_eks_cluster" "cluster" {
  name = module.eks_us_east_1.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks_us_east_1.cluster_name
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    token                  = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  }
}

provider "kubernetes" {
  host = data.aws_eks_cluster.cluster.endpoint
  token = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}