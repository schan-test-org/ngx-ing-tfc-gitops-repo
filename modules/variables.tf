variable "project" {
  type        = string
  default     = ""
  description = "project code which used to compose the resource name"
}

variable "env" {
  type        = string
  default     = ""
  description = "environment: dev, stg, qa, prod "
}

variable "region" {
  type        = string
  default     = ""
  description = "aws region to build network infrastructure"
}

variable "common_tags" {
  type        = map
  default     = {}
  description = "chart version for ebs csi controller"
}

variable "eks_cluster_name" {
  type        = string
  default     = ""
  description = "eks cluster name"
}

variable "eks_endpoint_url" {
  type        = string
  default     = ""
  description = "url of eks master."
}

variable "eks_cluster_certificate_authority_data" {
  type        = string
  default     = ""
  description = "PEM-encoded root certificates bundle for TLS authentication."
}

variable "eks_auth_token" {
  type        = string
  default     = ""
  description = "eks cluster auth token"
}

variable "helm_release_name" {
  type        = string
  default     = ""
  description = "helm release name"
}

variable "helm_chart_name" {
  type        = string
  default     = ""
  description = "helm chart name"
}

variable "helm_chart_version" {
  type        = string
  default     = ""
  description = "helm chart version"
}

variable "helm_repository_url" {
  type        = string
  default     = ""
  description = "helm chart repository url"
}

variable "create_namespace" {
  type        = bool
  default     = true
  description = "create the namespace if it does not yet exist"
}

variable "namespace" {
  type        = string
  default     = "kube-system"
  description = "namespace to install"
}

variable "ingress_class_name" {
  type        = string
  default     = ""
  description = "ingress class name"
}

variable "replica_count" {
  type        = number
  default     = 2
  description = "ingress class name"
}

variable "min_available" {
  type        = number
  default     = 1
  description = "pod disruption budgets of controller"
}

variable "annotations" {
  type        = string
  default     = ""
  description = "annotations to add"
}

variable "metrics_enabled" {
  type    = bool
  default = false
}

variable "service_monitor_enabled" {
  type    = bool
  default = false
  description = "configure whether to create service monitor"
}

variable "prometheus_rule_enabled" {
  type    = bool
  default = false
}

variable "tcp_service" {
  type    = string
  default = ""
}

variable "udp_service" {
  type    = string
  default = ""
}

variable "resources" {
  type    = string
  default = ""
}

variable "affinity" {
  type    = string
  default = ""
}

variable "tolerations" {
  type    = string
  default = ""
}

variable "node_selector" {
  type    = string
  default = ""
}

variable "topology_spread_constraints" {
  type    = string
  default = ""
}
