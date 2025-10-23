
#création d'une ressource datafactory 

resource "azurerm_data_factory" "mydatafact" {
  name = "my-dataFactory-tf"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

    identity {
    type = "SystemAssigned"
  }
}