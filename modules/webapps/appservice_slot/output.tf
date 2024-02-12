output "id" {
  value       = azurerm_app_service_slot.slots.id
  description = "The ID of the App Service Slot ."
}
output "name" {
  value       = azurerm_app_service_slot.slots.name
  description = "The name of the App Service Slot."
}
