recovery_vaults = {
  asr1 = {
    name               = "vault_re1"
    resource_group_key = "primary"
    region             = "region1"
    vnet_key           = "vnet_region1"
    subnet_key         = "asr_subnet"

    soft_delete_enabled = false

    

    # recovery_fabrics = {
    #   fabric1 = {
    #     name               = "fabric-primary"
    #     resource_group_key = "primary"
    #     region             = "region1"
    #   }
    # }

    # protection_containers = {
    #   container1 = {
    #     name                = "protection_container1"
    #     resource_group_key  = "primary"
    #     recovery_fabric_key = "fabric1"
    #   }
    # }

    # backup_policies = {
    #   vms = {
    #     policy1 = {
    #       name      = "VMBackupPolicy1"
    #       vault_key = "asr1"
    #       rg_key    = "primary"
    #       timezone  = "UTC"
    #       backup = {
    #         frequency = "Daily"
    #         time      = "23:00"
    #         #if not desired daily, can pick weekdays as below:
    #         #weekdays  = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    #       }
    #       retention_daily = {
    #         count = 10
    #       }
    #       retention_weekly = {
    #         count    = 42
    #         weekdays = ["Sunday", "Wednesday", "Friday", "Saturday"]
    #       }
    #       retention_monthly = {
    #         count    = 7
    #         weekdays = ["Sunday", "Wednesday"]
    #         weeks    = ["First", "Last"]
    #       }
    #       retention_yearly = {
    #         count    = 77
    #         weekdays = ["Sunday"]
    #         weeks    = ["Last"]
    #         months   = ["January"]
    #       }
    #     }
    #   }

    #   fs = {
    #     policy1 = {
    #       name      = "FSBackupPolicy1"
    #       vault_key = "asr1"
    #       rg_key    = "primary"
    #       timezone  = "UTC"
    #       backup = {
    #         frequency = "Daily"
    #         time      = "23:00"
    #       }
    #       retention_daily = {
    #         count = 10
    #       }
    #     }
    #   }
    # }

    recovery_fabrics = {
      fabric_primary = {
        name               = "fabric-primary"
        resource_group_key = "primary"
        region             = "region1"
      }
      fabric_secondary = {
        name               = "fabric-secondary"
        resource_group_key = "secondary"
        region             = "region2"
      }
    }

    protection_containers = {
      container_primary = {
        name                = "protection_container_primary"
        resource_group_key  = "primary"
        recovery_fabric_key = "fabric_primary"
      }
      container_secondary = {
        name                = "protection_container_secondary"
        resource_group_key  = "secondary"
        recovery_fabric_key = "fabric_secondary"
      }
    }

    replication_policies = {
      repl1 = {
        name               = "policy1"
        resource_group_key = "primary"

        recovery_point_retention_in_minutes                  = 24 * 60
        application_consistent_snapshot_frequency_in_minutes = 4 * 60
      }
    }
    replicated_vm = {
      replvm1 = {
        name                            = "example-replvm1"
        resource_group_key              = "secondary"
        # resource_group = {
        #   lz_key = ""
        #   resource_group_key = ""
        # }
        recovery_vault_key              = "asr1"
        # recovery_vault = {
        #   lz_key = ""
        #   recovery_vault_key = ""
        # }
        source_recovery_fabric_key      = "fabric_primary"
        source_vm_key                   = "example_vm1"
        # source_vm = {
        #   lz_key = ""
        #   vm_key = ""
        # }
        #source_vm_id = ""
        policy_key                      = "repl1"
        source_protection_container_key = "container_primary"
        target_resource_group_key       = "secondary"
        target_recovery_fabric_key      = "fabric_secondary"
        target_protection_container_key = "container_secondary"
        target_availability_set_key     = ""
        managed_os_disk = {
          mg_disk1 = {
            storage_account = {
              key = "recovery_cache_primary"
              # lz_key = ""
            }
            target_resource_group_key   = "secondary"
            target_disk_type            = "Premium_LRS"
            target_replica_disk_type    = "Premium_LRS"
            disk_encryption_set = {
              # lz_key = ""
              # disk_encryption_set_key= ""
            }
          }
        }
        # managed_disks = {
        #   mg_disk1 = {
        #     vm_disk_key = "data1"
        #     storage_account = {
        #       key = "recovery_cache_primary"
        #       # lz_key = ""
        #     }
        #     target_resource_group_key   = "secondary"
        #     target_disk_type            = "Premium_LRS"
        #     target_replica_disk_type    = "Premium_LRS"
        #   }
        # }
        network_interfaces = {
          nic0 = {
            source_network_interface_key  = "nic0"
            target_subnet_name            = "asrr_subnet"
            recovery_public_ip_address_id = "public_ip_secondary"
          }
        }

      }
    }

  }
}