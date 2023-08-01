   terraform {
        required_providers {
            azurerm = {
            source  = "hashicorp/azurerm"
            version = "=3.0.1"
            }
        }
        backend "azurerm" {
            resource_group_name  = "chatwithpdf"
            storage_account_name = "chatwithpdfstate"
            container_name       = "tfstate"
            key                  = "./terraform.tfstate"
        }

    }