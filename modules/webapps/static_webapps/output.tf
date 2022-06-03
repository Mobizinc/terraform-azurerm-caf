output "id" {
  value       = azurerm_static_site.static_site.id
  description = "The ID of the Static Web App."
}
output "default_site_hostname" {
  value       = azurerm_static_site.static_site.default_host_name
  description = "The default host name of the Static Web App."
}
