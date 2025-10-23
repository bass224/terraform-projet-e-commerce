
#attention j'ai corrigé manuellement le delimitateur de ligne car je n'arrivait pas à tester la pipeline, (je vais revoir cette config sur terraform, mais je pense faut faire un json ça marchera)

#on va maintenant créer une piepline d'une activité de copy pour copier les données vers la landing zone 

resource "azurerm_data_factory_pipeline" "pl_copy_sql_to_adls" {
  name            = "PL_Copy_SQL_to_ADLS"
  data_factory_id = azurerm_data_factory.mydatafact.id
  description     = "Pipeline qui copie les données de la table Ventes (SQL) vers ADLS (landing zone)."

  activities_json = jsonencode([
    {
      "name" = "Copy_SQL_to_ADLS",
      "type" = "Copy",
      "dependsOn" = [],
      "policy" = {
        "timeout" = "7.00:00:00",
        "retry" = 1,
        "retryIntervalInSeconds" = 30,
        "secureOutput" = false,
        "secureInput" = false
      },
      "typeProperties" = {
        "source" = {
          "type" = "SqlSource",
          "sqlReaderQuery" = "SELECT * FROM dbo.orders"
        },
        "sink" = {
          "type" = "DelimitedTextSink"
        }
      },
      "inputs" = [
        {
          "referenceName" = "ds_sql_orders",
          "type" = "DatasetReference"
        }
      ],
      "outputs" = [
        {
          "referenceName" = "ds_adls_orders",
          "type" = "DatasetReference"
        }
      ]
    }
  ])
}
