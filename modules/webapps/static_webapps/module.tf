data "azurerm_key_vault_secret" "static_webapps_token" {
  count          = var.key_vault_secret!= null ? 1 : 0
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
        appLocation = try(var.settings.applocation, null)
        githubActionSecretNameOverride = try(var.settings.githubactionsecretname, null)
        apiLocation = try(var.settings.apilocation, null)

      }
      publicNetworkAccess = try(var.settings.publicNetworkAccess, "Enabled")
      repositoryToken = try( data.azurerm_key_vault_secret.static_webapps_token[0].value , null)
      repositoryUrl = try(var.settings.repositoryurl, null)
    }
    sku = {
      name = try(var.settings.sku , "Free")
      tier = try(var.settings.sku , "Free")
    }

  })
 schema_validation_enabled = false
 response_export_values = [
    "id",
    "location"
  ]
}
