##
# (c) 2021 - CloudopsWorks OÜ - https://docs.cloudops.works/
#
data "azurerm_resource_group" "azure_rg" {
  name = var.resource_group
}

data "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.cluster_name
  resource_group_name = data.azurerm_resource_group.azure_rg.name
}

provider "kubernetes" {
  host                   = data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.host
  username               = data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.username
  password               = data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.password
  client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_certificate)
  client_key             = base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.host
    username               = data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.username
    password               = data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.password
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.aks_cluster.kube_config.0.cluster_ca_certificate)
  }
}