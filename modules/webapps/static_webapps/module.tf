data "azurerm_key_vault_secret" "static_webapps_token" {
  name           = var.key_vault_secret
  key_vault_id   = var.remote_objects.keyvault_id
}

resource "azapi_resource" "static_webapps" {
  type = "Microsoft.Web/staticSites@2022-09-01"
  name = var.name
  location = var.location
  parent_id = var.resource_group_name
  tags  = local.tags
  identity {
    type = try (var.identity.type , null)
    identity_ids = []
  }
  body = jsonencode({
    properties = {
      branch = try(var.settings.branch, null)
      buildProperties = {
        appLocation = try(var.settings.app_location, null)
        apiLocation = try(var.settings.api_location, null)

      }
      publicNetworkAccess = try(var.settings.public_access, "Enabled")
      repositoryToken = data.azurerm_key_vault_secret.static_webapps_token.value 
      repositoryUrl = try(var.settings.repository_url, null)
    }
    sku = {
      name = try(var.settings.sku , "Standard")
      tier = try(var.settings.sku , "Standard")
    }

  })
 schema_validation_enabled = false
 response_export_values = [
    "id",
    "location"
  ]
}

module "private_endpoint" {
  depends_on = [azapi_resource.static_webapps]
  source   = "../../networking/private_endpoint"
  for_each = var.remote_objects.private_endpoints

  resource_id         = azapi_resource.static_webapps.id
  location            = var.location
  name                = each.value.name
  resource_group_name = var.resource_group_name
  subnet_id           = try(var.remote_objects.vnets[var.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id, var.remote_objects.vnets[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id)
  settings            = each.value
  global_settings     = var.global_settings
  base_tags           = var.base_tags
  private_dns         = var.remote_objects.private_dns
  client_config       = var.client_config
}
