
#crétaion du conteneurs 

resource "azurerm_storage_container" "raw" {
    name ="raw"
    storage_account_name = azurerm_storage_account.stg.name
    container_access_type = "private"
  
}
