security_center_settings = {
    auto_provision      = "On"
    settings = {
      setting_name        = "MCAS"
      enabled             = "true"
    }
    contact = {
      email               = "contact@example.com"
      phone               = "+1-555-555-5555"
      alert_notifications = "true"
      alerts_to_admins    = "true"
    }
}

security_center_policy = {
  asp_example1 = {
    name    = "asp_example1"
    severity = "Medium"
    description = "This is test 1"
  }
  asp_example2 ={
    name     = "asp_example2"
    severity = "High"
    description = "This is test 2"
  }  
}

security_center_subscription_pricing = {
  tier          = "Standard"
  resource_type = "VirtualMachines"
}