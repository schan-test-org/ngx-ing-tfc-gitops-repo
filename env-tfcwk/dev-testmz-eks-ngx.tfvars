########################################
# Common
########################################
project     = "dev-eks-prj"
aws_region  = "ap-northeast-2"
env             = "dev"

default_tags = {
  dept  = "DEVOPS/TERRAFORM-CLOUD-GITOPS-TESTING"
}

########################################
# workspace setting
########################################
tfc_org = "schan-test"
tfc_wk = "dev-eks-tfc"

########################################
# etc setting
########################################
vpc_id                 = "vpc-0e8acf616f7d0dd34"
eks_cluster_name       = "test-deveks"

########################################
# helm setting
########################################
helm_release_name = "ingress-nginx"
helm_chart_name   = "ingress-nginx"
# helm_chart_version = "4.4.2"
helm_chart_version  = "4.0.18"
helm_repository_url = "https://kubernetes.github.io/ingress-nginx"

create_namespace = true
namespace        = "ingress-nginx"

replica_count = 1
min_available = 1

ingress_class_name = "nginx"

annotations = <<-EOT
service.beta.kubernetes.io/aws-load-balancer-name: devtest-ngx
service.beta.kubernetes.io/aws-load-balancer-backend-protocol: tcp
service.beta.kubernetes.io/aws-load-balancer-type: nlb-ip
service.beta.kubernetes.io/aws-load-balancer-scheme: internal
service.beta.kubernetes.io/aws-load-balancer-attributes: load_balancing.cross_zone.enabled=true
service.beta.kubernetes.io/aws-load-balancer-subnets: subnet-0dea2a38484eed006, subnet-0515d47ea98e7952e
EOT

# metrics_enabled         = true
# service_monitor_enabled = true
# prometheus_rule_enabled = true

metrics_enabled         = false
service_monitor_enabled = false
prometheus_rule_enabled = false

tcp_service = ""
# tcp_service = <<EOT
# 11887: mqtt/emqx:11887
# 18084: mqtt/emqx:18084
# 18085: mqtt/emqx:18085
# EOT

udp_service = ""

resources = ""
# resources           = <<EOT
# limits:
#   memory: "200Mi"
# requests:
#   cpu: "100m"
#   memory: "100Mi"
# EOT

affinity = <<EOT
nodeAffinity:
  requiredDuringSchedulingIgnoredDuringExecution:
    nodeSelectorTerms:
    - matchExpressions:
      - key: role
        operator: In
        values:
        - ops
EOT

node_selector = ""
# node_selector = <<EOT
# role: ops
# EOT

# tolerations   = ""
tolerations = <<EOT
- key: "role"
  operator: "Equal"
  value: "ops"
  effect: "NoSchedule"
EOT

topology_spread_constraints = ""







