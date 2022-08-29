resource "azurecaf_name" "static_site" {
  name          = var.name
  resource_type = "azurerm_app_service" # FIXME: missing naming convention provider for 'azurerm_static_site' (https://github.com/aztfmod/terraform-provider-azurecaf/issues/178)
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_static_site" "static_site" {
  name                = azurecaf_name.static_site.result
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags

  sku_size = var.sku_size
  sku_tier = var.sku_tier

  dynamic "identity" {
    for_each = try(var.identity, null) == null ? [] : [1]

    content {
      type         = var.identity.type
      identity_ids = lower(var.identity.type) == "userassigned" ? local.managed_identities : null
    }
  }
}

resource "azurerm_key_vault_secret" "api_token_secret" {
  depends_on = [azurerm_static_site.static_site ]
  count      = var.store_secret == "yes" ? 1 : 0
  
  name  = coalesce(
    try(var.api_token_name, null),
    format("%s-api-token", var.name) 
  )
  value        = azurerm_static_site.static_site.api_key
  key_vault_id = var.remote_objects.keyvault_id

  lifecycle {
    ignore_changes = [
      key_vault_id
    ]
  }
}
