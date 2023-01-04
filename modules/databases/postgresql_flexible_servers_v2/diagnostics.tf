module "diagnostics" {
  source   = "../../diagnostics"
  count  = lookup(var.settings, "diagnostic_profiles", null) == null ? 0 : 1
  
  
  resource_id       = azapi_resource.postgres_flexible_server.id
  resource_location = azapi_resource.postgres_flexible_server.location
  diagnostics       = var.remote_objects.diagnostics
  profiles          = var.settings.diagnostic_profiles
}
