resource "time_sleep" "server_configuration" {
  depends_on = [azapi_resource.postgres_flexible_server]

  create_duration  = "120s"
  destroy_duration = "300s"
}

resource "azurerm_postgresql_flexible_server_configuration" "postgresql" {
  depends_on = [time_sleep.server_configuration]
  for_each   = try(var.settings.postgresql_configurations, {})

  name      = each.value.name
  server_id = azapi_resource.postgres_flexible_server.id
  value     = each.value.value
}
