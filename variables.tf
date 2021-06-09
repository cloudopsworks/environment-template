##
# (c) 2021 - CloudopsWorks OÜ - https://docs.cloudops.works/
#
variable "default_helm_repo" {
  type    = string
  default = "finconectaopsclusterprod.azurecr.io"
}

variable "default_namespace" {
  type    = string
  default = "default"
}