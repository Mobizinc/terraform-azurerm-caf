output "location" {
  description = "Azure Region where the resource exists"
  value       = var.location
}

output "resource_group_name" {
  description = "Name of the Resource Group where the resource exists."
  value       = var.resource_group_name
}


output "outbound_endpoint" {
  value = {
    for key, value in try(var.outbound_endpoint, {}) : key => {
      id = azapi_resource.outbound_endpoint[key].id
    }
  }
}