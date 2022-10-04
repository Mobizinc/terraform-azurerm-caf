module "diagnostics" {
  source = "../diagnostics"
  count  = try(var.settings.diagnostic_profiles, null) == null ? 0 : 1
  
  resource_id       = var.resource_id
  # resource_id       = var.subscription_key == "logged_in_subscription" ? format("/subscriptions/%s", var.client_config.subscription_id) : (var.subscription_key == "other_subscription" ? format("/subscriptions/%s", try(var.local_combined_resources["subscriptions"][try(var.settings.subscription.lz_key, var.client_config.landingzone_key)][var.settings.subscription.key].subscription_id, null)) : format("/subscriptions/%s", var.settings.subscription_id))
  resource_location = var.global_settings.regions[var.global_settings.default_region]
  diagnostics       = var.diagnostics
  profiles          = try(var.settings.diagnostic_profiles, null)
  global_settings   = var.global_settings
}
