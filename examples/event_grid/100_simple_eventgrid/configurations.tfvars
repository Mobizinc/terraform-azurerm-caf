global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  evg_examples = {
    name   = "eventgrid"
  }
}

event_grid_topics = {
 grid1 = {
  resource_group_key    = "evg_examples"
  event_schema          = "EventGridSchema"
  public_network_access = "false"  # default is true
  identity_type         = "UserAssigned"
  users_identities      = ["user1", "user2"]
  mapping_fields        = {
    default_event_type    = "evg"
    default_data_version  = "1"
    default_subject       = "evg"
    topic      = "evg1"
    event_type = "evg"
    event_time = "3"
    data_version = "1"
    subject      = "evg"
  inbound_ip_rules = {
      rule1 = {
       ip_mask = "10.0.0.0/8"
       action  = "Allow"
      }
      rule2 = {
       ip_mask = "10.0.0.0/8"
       action  = "Allow"
      }
    }
    }
  }

  grid2 = {
    resource_group_key    = "evg_examples"
    event_schema          = "EventGridSchema"
    public_network_access = "false"  # default is true
    identity_type         = "SystemAssigned"
    mapping_fields        = {
      default_event_type    = "evg"
      default_data_version  = "1"
      default_subject       = "evg"
      topic      = "evg"
      event_type = "evg"
      event_time = "3"
      data_version = "1"
      subject      = "evg"
          }
    inbound_ip_rules = {
        rule1 = {
         ip_mask = "10.0.0.0/8"
         action  = "Allow"
        }
        rule2 = {
         ip_mask = "10.0.0.0/8"
         action  = "Allow"
      }
    }
    }
}