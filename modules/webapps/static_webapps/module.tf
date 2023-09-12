data "azurerm_key_vault_secret" "static_webapps_token" {
  count          = var.key_vault_secret != "" && var.remote_objects.keyvault_id != "" ? 1 : 0
  name           = var.settings.keyvault_secret_name
  key_vault_id   = var.remote_objects.keyvault_id
}

resource "azapi_resource" "static_webapps" {
  type = "Microsoft.Web/staticSites@2022-09-01"
  name = var.name
  location = var.location
  parent_id = var.resource_group_name
  identity {
    type = var.sku == Standard ? var.identity.type : null
    identity_ids = lower(var.identity.type) == "userassigned" ? local.managed_identities : null
  }
  body = jsonencode({
    properties = {
      branch = try(each.value.branch, null)
      buildProperties = {
        appLocation = try(each.value.applocation, null)
        githubActionSecretNameOverride = try(each.value.githubactionsecretname, null)
        apiLocation = try(each.value.apilocation, null)

      }
      publicNetworkAccess = try(each.value.publicNetworkAccess, "Enabled")
      repositoryToken = try( data.azurerm_key_vault_secret.static_webapps_token[0].value , null)
      repositoryUrl = try(each.value.repositoryurl, null)
    }
    sku = {
      name = try(each.value.sku , "Free")
      tier = try(each.value.sku , "Free")
    }

  })

 response_export_values = [
    "id",
    "location"
  ]
}
