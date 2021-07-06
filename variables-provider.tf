##
# (c) 2021 - CloudopsWorks OÜ - https://docs.cloudops.works/
#
variable "resource_group" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "azure_ad_rbac_enabled" {
  type    = bool
  default = false
}