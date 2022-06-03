# module "diagnostics" {
#   source   = "../../diagnostics"
#   count  = try(var.settings.diagnostic_profiles, null) == null ? 0 : 1

#   resource_id       = azurerm_postgresql_flexible_server.postgresql.id
#   resource_location = azurerm_postgresql_flexible_server.postgresql.location
#   diagnostics       = var.remote_objects.diagnostics
#   profiles          = var.settings.diagnostic_profiles
# }


 module "diagnostics" {
   source = "../../diagnostics"
  # count  = lookup(var.settings, "diagnostic_profiles", null) == null ? 0 : 1
   count  = try(var.settings.diagnostic_profiles, null) == null ? 0 : 1

   resource_id       = azurerm_postgresql_flexible_server.postgresql.id
   resource_location = azurerm_postgresql_flexible_server.postgresql.location
   diagnostics       = var.remote_objects.diagnostics
   profiles          = try(var.settings.diagnostic_profiles, {})
 }