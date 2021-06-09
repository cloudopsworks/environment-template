##
# (c) 2021 - CloudopsWorks OÜ - https://docs.cloudops.works/
#
data "kubernetes_namespace" "release_ns" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "app_release" {
  count      = var.oci_repo ? 0 : 1
  name       = var.release_name
  chart      = var.chart_name
  namespace  = data.kubernetes_namespace.release_ns.metadata.0.name
  repository = "https://${var.helm_repo}/"
  version    = var.chart_version
  wait       = false

  values = [
    file("values/${var.release_name}-values.yaml")
  ]

}

resource "null_resource" "helm_init_oci" {
  count = var.oci_repo ? 1 : 0

  triggers = {
    always_run = "${timestamp()}"
  }


  provisioner "local-exec" {
    command = "echo \"$HELM_CREDS_PASSWORD\" | helm registry login ${var.helm_repo} --username $HELM_CREDS_USER --password-stdin"
  }

  provisioner "local-exec" {
    command = "helm chart pull ${var.helm_repo}/${var.chart_name}:${var.chart_version}"
  }

  provisioner "local-exec" {
    command = "helm chart export ${var.helm_repo}/${var.chart_name}:${var.chart_version} --destination ./.release"
  }
}

resource "helm_release" "app_release_oci" {
  depends_on = [
    null_resource.helm_init_oci
  ]

  count     = var.oci_repo ? 1 : 0
  name      = var.release_name
  chart     = "./.release/${var.chart_name}"
  namespace = data.kubernetes_namespace.release_ns.metadata.0.name
  version   = var.chart_version
  wait      = false

  values = [
    file("values/${var.release_name}-values.yaml")
  ]

}
