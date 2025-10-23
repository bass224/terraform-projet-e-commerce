
#création d'une base de données sql 
#mais avnat il nous faut un server qui va hébergé nos bases de donées (le server en gors c'est l'infrasctructure d'accueil et la base donnée c'est le contenu réel)

#d'abord on crée un server 

# Serveur SQL logique
resource "azurerm_mssql_server" "sql_server" {
  name                         = "sql-server-ecom"        # doit être unique globalement
  resource_group_name           = azurerm_resource_group.rg.name        # ⚠️ ton RG existant
  location                      = azurerm_resource_group.rg.location            # même région que ton RG
  version                       = "12.0"
  administrator_login           = "bass"
  administrator_login_password  = "myserver1??"
}

# la Base de données sur ce serveur

resource "azurerm_mssql_database" "sql_database" {
  name                = "ecom_database"
  server_id           = azurerm_mssql_server.sql_server.id
  sku_name            = "S0" # ou "Basic", "GP_Gen5_2", etc.
}

#Puis on autorise notre pc à se connecter à la base (faut ajouter les règles de pare-feu ci dessous sinon ça marchera pas )
#car par defaut azure bloque tous les accès externe pour des raisons de sécurité

# autoriser ton PC à se connecter au serveur SQL

resource "azurerm_mssql_firewall_rule" "allow_my_ip" {
  name             = "allow-my-ip"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "92.151.25.36"   # ton IP publique actuelle
  end_ip_address   = "92.151.25.36"   # même IP pour une seule adresse
}


#si on veut autoriser les services azure comme azure data factory à se connecter sur la base aussi 

resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "allow-azure-services"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}
