terraform {
  required_version = ">= 1.2.0, < 2.0.0"

  required_providers {
    aws    = "~> 4.13.0"
    helm   = "~> 2.8.0"
  }
}