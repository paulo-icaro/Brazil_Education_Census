# ======================================================================== #
# === ACESSO API - MICRODADOS DO CENSO DA EDUCAÇÃO (BASICA E SUPERIOR) === #
# ======================================================================== #

# --- Script by Paulo Icaro --- #

# ------------------- #
# --- Bibliotecas --- #
# ------------------- #
library(httr2)                              # Conectar com a  API (Versão Moderna)
library(jsonlite)                           # Converter dados Json para um objeto
library(dplyr)                              # Manipular dados
library(svDialogs)                          # Exibir caixas de mensagens


# ----------------------------------------- #
# --- Funcao de Coleta de Ddados da API --- #
# ----------------------------------------- #
microdados_educacao_api = function(url){
  message('Iniciando a conexao com a API')
  Sys.sleep(1.05)
  
  # --- Conexao com a API --- #
  api_connection = try(expr = request(base_url = url) %>% req_perform(), silent = TRUE)
  tries = 1
  
  if(class(api_connection) == 'try-error'){
    while(class(api_connection) == 'try-error' & tries <= 5){
      message('Problemas na conexao. Tentando acessar a API novamente ...\n')
      Sys.sleep(1.05)
      api_connection = try(expr = request(base_url = url) %>% req_perform(), silent = TRUE)
      tries = tries + 1
      if(tries > 5){dlg_message(message = 'Conexao mal sucedida ! \nTente conectar com a API mais tarde.', type = 'ok')}
    }
  } else {
    message(message = 'Conexao bem sucedida ! \nDados sendo coletados ...\n')
    Sys.sleep(1.05)
  }
  
  api_connection = rawToChar(api_connection$body)                 # Raw to Json
  api_connection = fromJSON(api_connection, flatten = TRUE)       # Json to Data Frame
  
  # --- Output --- #
  return(api_connection)
}