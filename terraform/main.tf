terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }

    #pour databricks 
    databricks = {
      source = "databricks/databricks"
      version = "~> 1.1"
    }
  }
}

provider "azurerm" {
  features {}
}


#Création de mon groupe de ressources 

resource "azurerm_resource_group" "rg" {
  name     = "my_ecommerce-rg-terraform"
  location = "France Central"
}


/*
provider "databricks" {
  azure_workspace_resource_id = azurerm_databricks_workspace.db_workspace.id
  

  azure_tenant_id            = "18906ddb-63af-4592-ad44-470679255693"
}
*/

provider "databricks" {
  azure_workspace_resource_id = azurerm_databricks_workspace.db_workspace.id
  azure_client_id             = var.azure_client_id
  azure_client_secret         = var.azure_client_secret
  azure_tenant_id             = var.azure_tenant_id
}
