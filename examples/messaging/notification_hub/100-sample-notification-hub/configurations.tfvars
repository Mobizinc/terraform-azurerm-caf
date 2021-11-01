global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  nhub_example = {
    name = "nhub_example_vk"
  }
}

notification_hub_namespaces = {
  nhubname1example = {
     name = "nhubexamplea"
     resource_group_key = "nhub_example"
     namespace_type     = "NotificationHub"
     sku_name           = "Free"
     tags = {
       name = "something"
    }
  }
  nhubname2example = {
     name = "nhubexampleb"
     resource_group_key = "nhub_example"
     namespace_type     = "NotificationHub"
     sku_name           = "Free"
     tags = {
       name = "something"
    }
  }

}


notification_hub = {
  nhub1example = {
    name = "nhubexample1"
    namespace_name = "nhubexamplea"
    resource_group_key = "nhub_example"
  }

  
  nhub2example = {
    name = "nhubexample2"
    namespace_name = "nhubexampleb"
    resource_group_key = "nhub_example"
  }
}


notification_hub_authorization_rule = {
  nhubar1example = {
    name                  = "management-auth-rule-1"
    notification_hub_name = "nhubexample1"
    namespace_name        = "nhubexamplea"
    resource_group_key    = "nhub_example"
    manage                = "true"
    send                  = "true"
    listen                = "true"
    
  }


  nhubar2example = {
    name                  = "management-auth-rule-2"
    notification_hub_name = "nhubexample2"
    namespace_name        = "nhubexampleb"
    resource_group_key    = "nhub_example"
    manage                = "true"
    send                  = "true"
    listen                = "true"
      
  }
}
