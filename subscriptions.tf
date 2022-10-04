
module "subscriptions" {
  source = "./modules/subscriptions"

  for_each = var.subscriptions

  global_settings  = local.global_settings
  # resource_id      = each.value.subscription_id
  # resource_id      = each.key == "logged_in_subscription" ? format("/subscriptions/%s", local.client_config.subscription_id) : each.key == "other_subscription" ? format("/subscriptions/%s", try(local.combined_objects_subscriptions[try(each.value.subscription.lz_key, local.client_config.landingzone_key)][each.value.subscription.key].subscription_id, null)) : format("/subscriptions/%s", each.value.subscription_id)
  resource_id      = each.key == "logged_in_subscription" ? format("/subscriptions/%s", local.client_config.subscription_id) : format("/subscriptions/%s", each.value.subscription_id)
  subscription_key = each.key
  settings         = each.value
  client_config    = local.client_config
  diagnostics      = local.combined_diagnostics
}

module "subscription_billing_role_assignments" {
  source   = "./modules/subscription_billing_role_assignment"
  for_each = var.subscription_billing_role_assignments

  billing_role_definition_name = each.value.billing_role_definition_name
  client_config                = local.client_config
  cloud                        = local.cloud
  keyvaults                    = local.combined_objects_keyvaults
  settings                     = each.value
  principals = {
    azuread_users              = local.combined_objects_azuread_users
    managed_identities         = local.combined_objects_managed_identities
    azuread_service_principals = local.combined_objects_azuread_service_principals
  }
}

output "subscriptions" {
  value = module.subscriptions
}

module "sub_diagnostics" {
  source = "./modules/diagnostics"
  for_each = var.subscriptions
#   for_each = {
#     for key, value in local.combined_objects_subscriptions : key => value
#     if try(value.diagnostic_profiles, null) != null
#   }
  
#   resource_id       = each.value.resource_id
  resource_id       = each.key == "logged_in_subscription" ? format("/subscriptions/%s", local.client_config.subscription_id) : (each.key == "other_subscription" ? format("/subscriptions/%s", try(local.combined_objects_subscriptions[try(each.value.subscription.lz_key, local.client_config.landingzone_key)][each.value.subscription.key].subscription_id, null)) : format("/subscriptions/%s", each.value.subscription_id))
  resource_location = local.global_settings.regions[local.global_settings.default_region]
  diagnostics       = local.combined_diagnostics
  profiles          = try(each.value.diagnostic_profiles, null)
  global_settings   = local.global_settings
}
