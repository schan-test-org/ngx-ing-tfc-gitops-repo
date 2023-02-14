commonLabels: {}

controller:
  name: controller

  # -- Will add custom configuration options to Nginx https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/
  config: {}
  # -- Annotations to be added to the controller config configuration configmap.
  configAnnotations: {}
  # -- Will add custom headers before sending traffic to backends according to https://github.com/kubernetes/ingress-nginx/tree/main/docs/examples/customization/custom-headers
  proxySetHeaders: {}
  # -- Will add custom headers before sending response traffic to the client according to: https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/#add-headers
  addHeaders: {}
  # -- Optionally customize the pod dnsConfig.
  dnsConfig: {}
  # -- Optionally customize the pod hostname.
  hostname: {}

  replicaCount: ${replica_count}
  minAvailable: ${min_available}

  ingressClassResource:
    # -- Name of the ingressClass
    name: nginx
    # -- Is this ingressClass enabled or not
    enabled: true
    # -- Is this the default ingressClass for the cluster
    default: false
    # -- Controller-value of the controller that is processing this ingressClass
    controllerValue: "k8s.io/ingress-nginx"

    # -- Parameters is a link to a custom resource containing additional
    # configuration for the controller. This is optional if the controller
    # does not require extra parameters.
    parameters: {}

  ingressClass: ${ingress_class_name}
  
  podLabels: {}
  sysctls: {}

  tcp:
    # -- Allows customization of the tcp-services-configmap; defaults to $(POD_NAMESPACE)
    configMapNamespace: ""
    # -- Annotations to be added to the tcp config configmap
    annotations: {}

  udp:
    # -- Allows customization of the udp-services-configmap; defaults to $(POD_NAMESPACE)
    configMapNamespace: ""
    # -- Annotations to be added to the udp config configmap
    annotations: {}

  service:
    enabled: true
%{if annotations != "" ~}
    annotations:
      ${indent(6, annotations)}
%{ endif ~}
    
    enableHttp: true
    enableHttps: true

    targetPorts:
      https: http

  metrics:
    enabled: ${metrics_enabled}

    serviceMonitor:
      enabled: ${service_monitor_enabled}
      additionalLabels: {}
      ## The label to use to retrieve the job name from.
      ## jobLabel: "app.kubernetes.io/name"
      namespace: ${namespace}
      namespaceSelector: {}
      ## Default: scrape .Release.Namespace only
      ## To scrape all, use the following:
      ## namespaceSelector:
      ##   any: true
      scrapeInterval: 30s
      # honorLabels: true
      targetLabels: []
      relabelings: []
      metricRelabelings: []
    
    prometheusRule:
      enabled: ${prometheus_rule_enabled}
      additionalLabels: {}
      namespace: ${namespace}
      # rules: []
      rules:
        # These are just examples rules, please adapt them to your needs
        - alert: NGINXConfigFailed
          expr: count(nginx_ingress_controller_config_last_reload_successful == 0) > 0
          for: 1s
          labels:
            severity: critical
          annotations:
            description: bad ingress config - nginx config test failed
            summary: uninstall the latest ingress changes to allow config reloads to resume
        - alert: NGINXCertificateExpiry
          expr: (avg(nginx_ingress_controller_ssl_expire_time_seconds) by (host) - time()) < 604800
          for: 1s
          labels:
            severity: critical
          annotations:
            description: ssl certificate(s) will expire in less then a week
            summary: renew expiring certificates to avoid downtime
        - alert: NGINXTooMany500s
          expr: 100 * ( sum( nginx_ingress_controller_requests{status=~"5.+"} ) / sum(nginx_ingress_controller_requests) ) > 5
          for: 1m
          labels:
            severity: warning
          annotations:
            description: Too many 5XXs
            summary: More than 5% of all requests returned 5XX, this requires your attention
        - alert: NGINXTooMany400s
          expr: 100 * ( sum( nginx_ingress_controller_requests{status=~"4.+"} ) / sum(nginx_ingress_controller_requests) ) > 5
          for: 1m
          labels:
            severity: warning
          annotations:
            description: Too many 4XXs
            summary: More than 5% of all requests returned 4XX, this requires your attention

  priorityClassName: system-cluster-critical


%{if resources != "" ~}
  resources: 
    ${indent(4, resources)}
%{ endif ~}

%{if affinity != "" ~}
  affinity: 
    ${indent(4, affinity)}
%{ endif ~}

%{if node_selector != "" ~}
  nodeSelector: 
    ${indent(4, node_selector)}
%{ endif ~}

%{if tolerations != "" ~}
  tolerations:
    ${indent(4, tolerations)}
%{ endif ~}

%{if topology_spread_constraints != "" ~}
  topologySpreadConstraints:
    ${indent(4, topology_spread_constraints)}
%{ endif ~}

  podAnnotations: {}
  terminationGracePeriodSeconds: 300

  autoscaling:
    enabled: false

  keda:
    enabled: false

## Default 404 backend
##
defaultBackend:
  ##
  enabled: false

%{if resources != "" ~}
  resources: 
    ${indent(4, resources)}
%{ endif ~}

%{if affinity != "" ~}
  affinity: 
    ${indent(4, affinity)}
%{ endif ~}

%{if node_selector != "" ~}
  nodeSelector: 
    ${indent(4, node_selector)}
%{ endif ~}

%{if tolerations != "" ~}
  tolerations:
    ${indent(4, tolerations)}
%{ endif ~}

%{if topology_spread_constraints != "" ~}
  topologySpreadConstraints:
    ${indent(4, topology_spread_constraints)}
%{ endif ~}

rbac:
  create: true
  scope: false

serviceAccount:
  create: true
  name: ""
  automountServiceAccountToken: true
  # -- Annotations for the controller service account
  annotations: {}

# -- Optional array of imagePullSecrets containing private registry credentials
## Ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
imagePullSecrets: []
# - name: secretName

# -- TCP service key:value pairs
## Ref: https://github.com/kubernetes/ingress-nginx/blob/main/docs/user-guide/exposing-tcp-udp-services.md
##
%{if tcp_service != "" ~}
tcp:
  ${indent(2, tcp_service)}
%{ endif ~}
#  8080: "default/example-tcp-svc:9000"

# -- UDP service key:value pairs
## Ref: https://github.com/kubernetes/ingress-nginx/blob/main/docs/user-guide/exposing-tcp-udp-services.md
##
%{if udp_service != "" ~}
udp:
  ${indent(2, udp_service)}
%{ endif ~}
#  53: "kube-system/kube-dns:53"