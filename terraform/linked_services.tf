
#Création des linked services 

#1- link service source (via sql authentification, mais on peut le faire aussi par manged identity plus tard c'est utile de le savoir)


resource "azurerm_data_factory_linked_service_azure_sql_database" "sql_ls" {
  name                = "LS_AzureSQLDatabase_MI_tf"
  data_factory_id     = azurerm_data_factory.mydatafact.id
  description         = "Connexion à Azure SQL Database via Managed Identity"
  connection_string = "Server=tcp:sql-server-ecom.database.windows.net,1433;Database=ecom;User ID=${var.sql_user};Password=${var.sql_password}"

}



#2 - link service destination 
#pour que ce lik service marche, il faut aller sur azure, datafactory, controle d'acces iam, roles, taper Contributeur aux données Blob du stockage et peut etre contributeur de compte de stockage  cocher puis  ajouter une attribution de role
#puis suivant, puis identitié managé puis en dessous memenbre, choisir mon abonnement et prendre azure datafactory, et donc enregistrer, si adf était ouvert fermé complétement et réouvrir avant que les acces
#ne fonctionne puis on pourra tester le link service déjà crée, sinon ça ne marchera pas il dira il a pas les droit 
#autrement, on eut faire via terraform pour lui donné l'accès et evite la manip qu'on vient de faire (je le verai après)



resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "adls_ls" {
    name ="LS_adls_tf"
    data_factory_id = azurerm_data_factory.mydatafact.id
    use_managed_identity = true
    url = "https://ecommercestorage224tf.dfs.core.windows.net/" 
}