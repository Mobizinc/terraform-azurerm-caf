
data "azurerm_key_vault_secret" "example" {
  name                = var.settings.keyvault_secret_name
  key_vault_id        = var.remote_objects.keyvault_id
}

resource "azurerm_resource_group_template_deployment" "example" {
  depends_on          = [data.azurerm_key_vault_secret.example]
  name                = var.settings.name
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"
  parameters_content  = jsonencode({
  
    "name"             = { value = var.settings.name }
    "sku"              = { value = var.settings.sku }
    "repositoryUrl"    = { value = var.settings.github_repo }
    "skucode"          = { value = var.settings.sku }
    "branch"           = { value = var.settings.github_branch }
    "repositoryToken"  = { value = data.azurerm_key_vault_secret.example.value }
  })
  template_content     = file(local.arm_filename)
}