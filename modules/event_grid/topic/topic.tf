resource "azurerm_eventgrid_topic" "example" {
  name                           = var.topic_name
  location                       = var.location
  resource_group_name            = var.resource_group_name
  input_schema                   = var.settings.event_schema
  public_network_access_enabled  = var.settings.public_network_access
  identity {
    type   = var.settings.identity_type
    identity_ids = try(var.settings.users_identities,null)
  }
  
  input_mapping_default_values {
    event_type    =  try(var.settings.mapping_fields.default_event_type, null)
    data_version  =  try(var.settings.mapping_fields.default_data_version, null)
    subject       =  try(var.settings.mapping_fields.default_subject, null)
  }
  input_mapping_fields {
    id           = try(var.settings.mapping_fields.id, null)
    topic        = try(var.settings.mapping_fields.topic, null)
    event_type   = try(var.settings.mapping_fields.event_type, null)
    event_time   = try(var.settings.mapping_fields.event_time, null)
    data_version = try(var.settings.mapping_fields.data_version, null)
    subject      = try(var.settings.mapping_fields.subject, null)
  }

  dynamic "inbound_ip_rule" {
    for_each = try(var.settings.inbound_ip_rules,{})
    content{
    ip_mask  = try(inbound_ip_rule.value.ip_mask,null)
    action   = try(inbound_ip_rule.value.action,null)
    }
  }

  tags                = local.tags
}