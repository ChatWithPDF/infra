   terraform {
        required_providers {
            azurerm = {
            source  = "hashicorp/azurerm"
            version = "=3.0.1"
            }
        }
        backend "azurerm" {
            resource_group_name  = "agrimitra"
            storage_account_name = "agrimitrastate"
            container_name       = "tfstate"
            key                  = "./terraform.tfstate"
        }

    }