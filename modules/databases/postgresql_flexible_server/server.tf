resource "azurerm_postgresql_flexible_server" "postgresql" {

  name                = var.settings.name
  resource_group_name = var.resource_group_name
  location            = var.location
  version             = var.settings.version
  sku_name            = var.settings.sku_name
  zone                = try(var.settings.zone, "1")
  delegated_subnet_id = var.delegated_subnet_id
  private_dns_zone_id = var.private_dns_zone_id
  administrator_login          = var.settings.administrator_login
  administrator_login_password = try(var.settings.administrator_login_password, azurerm_key_vault_secret.postgresql_admin_password.0.value)

  storage_mb                        = try(var.settings.storage_mb, null)
  create_mode                       = try(var.settings.create_mode, "Default")
  public_network_access_enabled     = try(var.settings.public_network_access_enabled, false)
  tags                              = local.tags



}

# Generate postgresql server random admin password if not provided in the attribute administrator_login_password
resource "random_password" "postgresql_admin" {
  count = try(var.settings.administrator_login_password, null) == null ? 1 : 0

  length           = 128
  special          = true
  upper            = true
  number           = true
  override_special = "$#%"
}

# Store the generated password into keyvault
resource "azurerm_key_vault_secret" "postgresql_admin_password" {
  count = try(var.settings.administrator_login_password, null) == null ? 1 : 0

  name         = format("%s-password", azurerm_postgresql_flexible_server.postgresql.result)
  value        = random_password.postgresql_admin.0.result
  key_vault_id = var.keyvault_id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}















