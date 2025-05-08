resource "azurerm_storage_account" "eric_storage" {
  name                     = "ericaistorage"
  resource_group_name      = data.azurerm_resource_group.ERIC.name
  location                 = "australiaeast"
  account_tier             = "Standard"
  account_replication_type = "LRS"

    tags = merge(
    local.common_tags,
    {
      description = "Storage account for AI Foundry"
    }
  )

}

resource "azurerm_key_vault" "eric_vault" {
  name                = "eric-ai-vault"
  location            = "australiaeast"
  resource_group_name = data.azurerm_resource_group.ERIC.name
  sku_name            = "standard"
  tenant_id           = data.azurerm_subscription.current.tenant_id

  purge_protection_enabled = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List", "Create", "Delete", "Update"
    ]

    secret_permissions = [
      "Get", "List", "Set", "Delete"
    ]
  }

  tags = merge(
    local.common_tags,
    {
      description = "Key Vault for AI Foundry"
    }
  )
}

resource "azurerm_ai_services" "eric-ai-service" {
  name                = "eric-ai-service"
  location            = "australiaeast"
  resource_group_name = data.azurerm_resource_group.ERIC.name
  sku_name            = "S0"

  tags = merge(
    local.common_tags,
    {
      description = "AI Services for AI Foundry"
    }
  )
}

resource "azurerm_ai_foundry" "eric-ai-foundry" {
  name                = "eric-ai-foundry"
  location            = "australiaeast"
  resource_group_name = data.azurerm_resource_group.ERIC.name
  storage_account_id  = azurerm_storage_account.eric_storage.id
  key_vault_id        = azurerm_key_vault.eric_vault.id

  identity {
    type = "SystemAssigned"
  }

  tags = merge(
    local.common_tags,
    {
      description = "AI Foundry Workspace"
    }
  )
}

resource "azurerm_role_assignment" "ai_developer_role" {
  for_each = data.azuread_user.users

  scope                = azurerm_ai_foundry.eric-ai-foundry.id
  role_definition_name = "Azure AI Developer"
  principal_id         = each.value.object_id
}