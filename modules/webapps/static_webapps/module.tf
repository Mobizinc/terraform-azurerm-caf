resource "azapi_resource" "static_webapps" {
  type = "Microsoft.Web/staticSites@2022-09-01"
  name = "string"
  location = "string"
  parent_id = "string"
  tags = {
    tagName1 = "tagValue1"
    tagName2 = "tagValue2"
  }
  identity {
    type = "string"
    identity_ids = []
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
