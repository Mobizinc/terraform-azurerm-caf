output "id" {
  description = "The Automation Account Webhook ID."
  value       = azurerm_automation_webhook.automation_webhook.id
}

output "uri" {
  description = "Generated URI for this Webhook."
  value       = azurerm_automation_webhook.automation_webhook.id
}
