module "ec2_example" {
  source        = "./my-ec2-module"
  ami_id        = "ami-1234567890abcdef0"
  instance_type = "t2.micro"
  subnet_id     = "subnet-abc123"
  name          = "MyInstance"
}

terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "eks_cluster" {
  source          = "./modules/eks"
  cluster_name    = "my-eks-cluster"
  cluster_version = "1.28"
  subnet_ids      = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id
  node_groups = {
    default = {
      instance_type = "t3.medium"
      desired_size  = 2
      max_size      = 3
      min_size      = 1
    }
  }
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
}





 