############################# data : local #######################################

locals {
  region                    = var.aws_region
  # eks_package_bucket_name   = var.backend_s3_bucket_name
  # eks_package_bucket_key    = var.eks_s3_key
  # eks_package_bucket_region = local.region
  # eks_tfstat_path           = var.eks_tfstat_path
}

############################# data : eks-c #######################################

data "aws_eks_cluster_auth" "cluster" {
  name = local.eks_cluster_name
}


############################# data : remote #######################################

data "terraform_remote_state" "eks" {
  # count = var.vpc_id == "" ? 1 : 0
  # tfstate outputs-list : 
  # how to get : data.terraform_remote_state.eks.0.outputs.xxx 
  backend = "remote"
  config = {
    organization = var.tfc_org
    workspaces = {
      name = var.tfc_wk
    }
  }
}
