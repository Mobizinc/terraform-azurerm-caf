resource "azapi_resource" "static_webapps" {
  type = "Microsoft.Web/staticSites@2022-09-01"
  name = var.name
  location = var.location
  parent_id = var.resource_group_name
  identity {
    type = try( var.identity.type , null)
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
      repositoryToken = data.azurerm_key_vault_secret.example.value
      repositoryUrl = try(each.value.repositoryurl, null)
    }
    sku = {
      name = try(each.value.sku , "Free"
      tier = try(each.value.sku , "Free"
    }

  })

 response_export_values = [
    "id",
    "location"
  ]
}



resource "azapi_resource" "static_webapps" {
  type = "Microsoft.Web/staticSites@2022-09-01"
  name = var.name
  location = var.location
  parent_id = var.resource_group_name
  tags = local.tags
  identity {
    type = var.identity.type
    identity_ids = lower(var.identity.type) == "userassigned" ? local.managed_identities : null
  }
  body = jsonencode({
    properties = {
      allowConfigFileUpdates = bool
      branch = "string"
      buildProperties = {
        apiBuildCommand = "string"
        apiLocation = "string"
        appArtifactLocation = "string"
        appBuildCommand = "string"
        appLocation = "string"
        githubActionSecretNameOverride = "string"
        outputLocation = "string"
        skipGithubActionWorkflowGeneration = bool
      }
      enterpriseGradeCdnStatus = "string"
      provider = "string"
      publicNetworkAccess = "string"
      repositoryToken = "string"
      repositoryUrl = "string"
      stagingEnvironmentPolicy = "string"
      templateProperties = {
        description = "string"
        isPrivate = bool
        owner = "string"
        repositoryName = "string"
        templateRepositoryUrl = "string"
      }
    }
    sku = {
      capabilities = [
        {
          name = "string"
          reason = "string"
          value = "string"
        }
      ]
      capacity = int
      family = "string"
      locations = [
        "string"
      ]
      name = "string"
      size = "string"
      skuCapacity = {
        default = int
        elasticMaximum = int
        maximum = int
        minimum = int
        scaleType = "string"
      }
      tier = "string"
    }
    kind = "string"
  })
}
