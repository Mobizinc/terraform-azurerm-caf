global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  dac_test = {
    name = "databricks-access-connectors"
    tags = {
      Environment      = "CAF-TEST-ENVIRONMENT"
      Project_Code     = "CAF-TEST"
      Owner            = "vkuzmenko@mobizinc.com"

    }
  }
}

databricks_access_connectors = {
  dac_1 = {
      name = "example-name"
      resource_group_key = "dac_test"
      identity = {
        type   = "UserAssigned"
        managed_identity_keys = ["dac_test"]
    }
     tags = {
       test = "test"
       test1 = "test"
     }
  }
}

managed_identities = {
  dac_test = {
    name               = "mi-dac-test"
    resource_group_key = "dac_test"
  }
}