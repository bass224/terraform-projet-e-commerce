
#création des datasets  qui sont les objets qui décrivent où et comment ADF lit et écrit les données 

resource "azurerm_data_factory_dataset_sql_server_table" "ds_sql_orders" {
  name                = "DS_SQL_Orders"
  data_factory_id     = azurerm_data_factory.mydatafact.id
  linked_service_name = azurerm_data_factory_linked_service_azure_sql_database.sql_ls.name
  description         = "Dataset source - Table ventes dans Azure SQL Database"

  table_name = "dbo.orders"

}


#création du dataset de destinatation 

/*
resource "azurerm_data_factory_dataset_delimited_text" "ds_adls_ventes" {
  name                = "DS_ADLS_Orders"
  data_factory_id     = azurerm_data_factory.mydatafact.id
  linked_service_name = azurerm_data_factory_linked_service_data_lake_storage_gen2.adls_ls.name
  description         = "Dataset destination - Fichier ventes dans le Data Lake (landing zone)"

  azure_blob_storage_location {
    container = "landing"
    path      = "orders"
    filename  = "ventes_@{formatDateTime(pipeline().TriggerTime, 'yyyyMMdd')}.csv"
    #filename  = "orders.csv"
  }

  column_delimiter    = ","
  first_row_as_header = true

}

*/

#nb: on fait un json pour deployer car c'est conseillé, et aussi surtout car il ne mettait pas le delimieteur de ligne en defaut, ça bloquait le dataset et aussi la pipeline
#il fallait le changer manuellement
#mais du coup pour que ça marche, faut juste enlever le column_delimieteur et aussi le row_delimiteur et donc il prendra par defaut. 
#Normalement même le code en haut marche si on enlève le column_delimiteur (mais l'idéal c'est de faire un json et le deployer, car terraform n'est pas fait pour configurer les dataset et link service et flow)


resource "azurerm_resource_group_template_deployment" "dataset_ventes" {
  name                = "deploy-datasets_adls"
  resource_group_name = azurerm_resource_group.rg.name
  deployment_mode     = "Incremental"

  #template_content = file("${path.module}/dataset_adls.json")
  template_content = templatefile("${path.module}/dataset_adls.json", {})
  parameters_content = jsonencode({
    dataFactoryName = {
      value = azurerm_data_factory.mydatafact.name
    }
  })

  depends_on = [
    azurerm_data_factory.mydatafact
  ]
}
