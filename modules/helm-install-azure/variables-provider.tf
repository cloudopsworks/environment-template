##
# (c) 2021 - CloudopsWorks OÜ - https://docs.cloudops.works/
#
variable "resource_group" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "ad_rbac" {
  type    = bool
  default = false
}