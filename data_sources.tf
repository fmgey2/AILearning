data "azurerm_subscription" "current" {
  subscription_id = "68197256-a204-4801-8d8e-9a5c8623c38b"
}

data "azurerm_resource_group" "ERIC" {
  name = "ERIC"
}

data "azurerm_client_config" "current" {}

data "azuread_user" "users" {
  for_each = toset(local.users)
  mail     = each.value
}