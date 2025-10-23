
#Création d'un compte de stockage 

resource "azurerm_storage_account" "stg" {
    name ="ecommercestorage224tf"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    account_replication_type = "LRS"
    account_tier = "Standard"
}