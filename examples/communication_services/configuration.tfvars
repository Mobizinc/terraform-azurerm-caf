global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  acs = {
    name   = "acs-example"
    region = "region1"
  }
}

communication_services = {
  acs1 = {
    name               = "acs1"
    resource_group_key = "acs"
    data_location      = "United States"
    diagnostic_profiles = {
      central_logs_region1 = {
        definition_key   = "azure_communication_service"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }
  acs2 = {
    name               = "acs2"
    resource_group_key = "acs"
    data_location      = "Europe"
    diagnostic_profiles = {
      central_logs_region1 = {
        definition_key   = "azure_communication_service"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }
}