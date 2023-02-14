locals {

  values = templatefile("${path.module}/template/ingress-nginx-values.tpl", { 
    namespace     = var.namespace
    annotations   = var.annotations
    replica_count = var.replica_count
    min_available = var.min_available

    ingress_class_name = var.ingress_class_name

    metrics_enabled         = var.metrics_enabled
    service_monitor_enabled = var.service_monitor_enabled
    prometheus_rule_enabled = var.prometheus_rule_enabled

    tcp_service = var.tcp_service
    udp_service = var.udp_service

    resources     = var.resources
    affinity      = var.affinity
    node_selector = var.node_selector
    tolerations   = var.tolerations
    topology_spread_constraints = var.topology_spread_constraints    
  })

}