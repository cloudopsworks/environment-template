##
# (c) 2021 - CloudopsWorks OÜ - https://docs.cloudops.works/
#
provider "azurerm" {
  features {}

  use_msi         = true
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}
