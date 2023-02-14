provider "aws" {
  region = var.region
}

provider "helm" {
	kubernetes {
		cluster_ca_certificate = base64decode(var.eks_cluster_certificate_authority_data)
		host                   = var.eks_endpoint_url
		token									 = var.eks_auth_token
	}
}
