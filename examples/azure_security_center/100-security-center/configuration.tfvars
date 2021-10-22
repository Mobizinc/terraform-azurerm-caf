security_center = {
    email               = "contact@example.com"
    phone               = "+1-555-555-5555"
    alert_notifications = "true"
    alerts_to_admins    = "true"
    auto_provision      = "On"
    setting_name        = "MCAS"
    enabled             = "true"
    policy = {
    
     asp_example1 = {
        severity = "Medium"
        description = "this is test"
    }
     asp_example2 ={
        severity = "High"
        description = "This is test 2"
    }
    }
}