
#on va créer un job, qui va exécuter notre pipeline de données : 
#soit on va le faire tous les jours à une heure donnée
#soit on va déclencher le pipeline quand un nouveau fichier arrive dans un dossier 
#soit on va le déclencher manuellement 

resource "azurerm_data_factory_trigger_schedule" "trg_daily_copy" {
  name            = "TRG_Daily_Copy_SQL_to_ADLS"
  data_factory_id = azurerm_data_factory.mydatafact.id
  description     = "Déclencheur quotidien à 02:00."

  
  frequency   = "Day"           # "Minute" | "Hour" | "Day" | "Week" | "Month"
  interval    = 1               # toutes les 1 unités de 'frequency'
  start_time  = "2025-10-23T00:00:00Z"  # en UTC
  end_time =    "2025-10-24T23:59:00Z"

  time_zone   = "Romance Standard Time"       #prend le fuseau horaire de paris mais utc c'est gmt 
  activated   = true            # démarre le trigger

  # ⏰ fenêtre exacte d’exécution dans la journée
  schedule {
    hours   = [16]               # 02h
    minutes = [0]
  }

  # 🔗 pipeline à lancer
  pipeline {
    name = azurerm_data_factory_pipeline.pl_copy_sql_to_adls.name
    # parameters = { ... }      # optionnel si ta pipeline a des paramètres
  }
}


