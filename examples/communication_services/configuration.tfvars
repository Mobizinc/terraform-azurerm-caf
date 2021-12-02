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
  }
  acs2 = {
    name               = "acs2"
    resource_group_key = "acs"
    data_location      = "Europe"
  }
}