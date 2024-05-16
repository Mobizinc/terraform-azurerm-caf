resource "azurecaf_name" "postgresql_flexible_server" {
  name          = var.settings.name
  resource_type = "azurerm_postgresql_flexible_server"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azapi_resource" "postgres_flexible_server" {
  type = "Microsoft.DBforPostgreSQL/flexibleServers@2023-03-01-preview"
  name = azurecaf_name.postgresql_flexible_server.result
  location = var.location
  parent_id = var.resource_group_name
  tags = merge(local.tags, lookup(var.settings, "tags", {}))
  schema_validation_enabled = false
  body = jsonencode({
    properties = {
      administratorLogin = try(var.settings.create_mode, "Default") == "Default" ? try(var.settings.administrator_username, "pgadmin") : null
      administratorLoginPassword = try(var.settings.create_mode, "Default") == "Default" ? try(var.settings.administrator_password, azurerm_key_vault_secret.postgresql_administrator_password.0.value) : null
      availabilityZone = try(var.settings.zone, "1")
      backup = {
        backupRetentionDays = tonumber(try(var.settings.backup_retention_days, "7"))
        geoRedundantBackup = try(var.settings.georedundantbackup, "Disabled")
      }
      createMode = try(var.settings.create_mode, "Default")
      highAvailability = {
        mode = try(var.settings.highavailability, "Disabled")
        standbyAvailabilityZone = try(var.settings.standbyavailabilityzone, null)
      }
      maintenanceWindow = {
        customWindow = try(var.settings.maintenance_window.customwindow, "Disabled")
        dayOfWeek = tonumber(try(var.settings.maintenance_window.day_of_week, 0))
        startHour = tonumber(try(var.settings.maintenance_window.start_hour, 0))
        startMinute = tonumber(try(var.settings.maintenance_window.start_minute, 0))
      }
      network = {
        delegatedSubnetResourceId = var.remote_objects.subnet_id
        privateDnsZoneArmResourceId = var.remote_objects.private_dns_zone_id
      }
      pointInTimeUTC = try(var.settings.create_mode, "PointInTimeRestore") == "PointInTimeRestore" ? try(var.settings.point_in_time_restore_time_in_utc, null) : null
      sourceServerResourceId = try(var.settings.create_mode, "PointInTimeRestore") == "PointInTimeRestore" ? try(var.settings.source_server_id, null) : null
      storage = {
        storageSizeGB = tonumber(var.settings.storage_gb)
      }
      version = try(var.settings.version, null)
    }
    sku = {
      name = try(var.settings.sku_name, null)
      tier = try(var.settings.sku_tier, null)
    }
  })
  response_export_values  = ["*"]
}

#Store the postgresql_flexible_server administrator_username into keyvault if the attribute keyvault{} is defined.
resource "azurerm_key_vault_secret" "postgresql_administrator_username" {
  count = lookup(var.settings, "keyvault", null) == null ? 0 : 1

  name         = format("%s-username", azurecaf_name.postgresql_flexible_server.result)
  value        = try(var.settings.administrator_username, "pgadmin")
  key_vault_id = var.remote_objects.keyvault_id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

# Generate random postgresql_flexible_administrator_password if attribute administrator_password not provided.
resource "random_password" "postgresql_administrator_password" {
  count = lookup(var.settings, "administrator_password", null) == null ? 1 : 0

  length           = try(var.settings.administrator_password_length, 128)
  upper            = true
  number           = true
  special          = true
  override_special = "$#%"
}

# Store the postgresql_flexible_administrator_password into keyvault if the attribute keyvault{} is defined.
resource "azurerm_key_vault_secret" "postgresql_administrator_password" {
  count = lookup(var.settings, "keyvault", null) == null ? 0 : 1

  name         = format("%s-password", azurecaf_name.postgresql_flexible_server.result)
  value        = try(var.settings.administrator_password, random_password.postgresql_administrator_password.0.result)
  key_vault_id = var.remote_objects.keyvault_id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}
