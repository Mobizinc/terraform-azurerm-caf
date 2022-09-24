resource "azurecaf_name" "mssqlmi" {
  name          = var.settings.name
  resource_type = "azurerm_mssql_mi" 
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_mssql_managed_instance" "mssqlmi" {
  name                = azurecaf_name.mssqlmi.result
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags
  license_type        = var.settings.license_type
  sku_name            = var.settings.sku_name
  storage_size_in_gb  = var.settings.storage_size_in_gb
  subnet_id           = var.subnet_id
  vcores              = var.settings.vcores
  collation           = try(var.settings.collation, null)
  minimum_tls_version = try(var.settings.collation, null)
  proxy_override      = try(var.settings.proxy_override, null)
  public_data_endpoint_enabled = try(var.settings.public_data_endpoint_enabled, false)
  timezone_id          = try(var.settings.timezone_id, null)
  storage_account_type = try(var.settings.storage_account_type, null)
  
  administrator_login  = var.settings.administrator_login
  administrator_login_password = try(var.settings.administrator_password, azurerm_key_vault_secret.mssql_managed_instance_administrator_password.0.value)

  dynamic "identity" {
    for_each = try(var.identity, null) == null ? [] : [1]

    content {
      type         = var.identity.type
      
    }
  }
}


# Generate random mssql_managed_instance administrator_password if attribute administrator_password not provided.
resource "random_password" "mssql_managed_instance_administrator_password" {
  count = try(var.settings.administrator_password, null) == null ? 1 : 0

  length           = 128
  upper            = true
  number           = true
  special          = true
  override_special = "$#%"
}

# Store the mssql_managed_instance_administrator_password into keyvault if the attribute keyvault{} is defined.
resource "azurerm_key_vault_secret" "mssql_managed_instance_administrator_password" {
  count = try(var.settings.administrator_password, null) == null ? 1 : 0

  name         = format("%s-password", azurecaf_name.mssqlmi.result)
  value        = try(var.settings.administrator_password, random_password.mssql_managed_instance_administrator_password.0.result)
  key_vault_id = var.keyvault_id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "azurerm_mssql_managed_database" "mssqlmi" {
  depends_on = [azurerm_mssql_managed_instance.mssqlmi]
  for_each   = try(var.settings.databases, {})
  name                = each.value.name
  managed_instance_id = azurerm_mssql_managed_instance.mssqlmi.id
}

module "private_endpoint" {
  source   = "../../networking/private_endpoint"
  for_each = var.remote_objects.private_endpoints

  resource_id         = azurerm_mssql_managed_instance.mssqlmi.id
  location            = var.location
  name                = each.value.name
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  settings            = each.value
  global_settings     = var.global_settings
  base_tags           = var.base_tags
  private_dns         = var.remote_objects.private_dns
  client_config       = var.client_config
}

resource "azurerm_mssql_managed_instance_active_directory_administrator" "example" {
  depends_on = [azurerm_mssql_managed_instance.mssqlmi]
  for_each =  try(var.settings.active_directory_administrator, {})

  managed_instance_id = azurerm_mssql_managed_instance.mssqlmi.id
  #login          = each.value.login
  login_username = try(var.settings.active_directory_administrator.login_username, try(var.azuread_groups[var.client_config.landingzone_key][var.settings.active_directory_administrator.azuread_group_key].name, var.azuread_groups[var.settings.active_directory_administrator.lz_key][var.settings.active_directory_administrator.azuread_group_key].name))
  object_id      = try(var.settings.active_directory_administrator.object_id, try(var.azuread_groups[var.client_config.landingzone_key][var.settings.active_directory_administrator.azuread_group_key].id, var.azuread_groups[var.settings.active_directory_administrator.lz_key][var.settings.active_directory_administrator.azuread_group_key].id))
  tenant_id      = try(var.settings.active_directory_administrator.tenant_id, try(var.azuread_groups[var.client_config.landingzone_key][var.settings.active_directory_administrator.azuread_group_key].tenant_id, var.azuread_groups[var.settings.active_directory_administrator.lz_key][var.settings.active_directory_administrator.azuread_group_key].tenant_id))
}