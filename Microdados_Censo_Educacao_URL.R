# ================================================================= #
# === URL - MICRODADOS DO CENSO DA EDUCAÇÃO (BASICA E SUPERIOR) === #
# ================================================================= #


# --- Script por Paulo Icaro --- #


# ------------------------------ #
# --- Funcao Geradora de URL --- #
# ------------------------------ #
microdados_educacao_url = function(type, regiao, estado, municipio, periodo){
  
  # Educacao Basica
  if(type == 'ens_bas'){
    micr_educ_url = paste0('http://127.0.0.1:8000/educacao_basica?regiao=', regiao, '&estado=', estado, '&municipio=', municipio, '&periodo=', periodo)
    return(micr_educ_url)
  }
  
  # Educacao Basica - Ensino Tecnico
  if(type == 'ens_tec'){
    micr_educ_url = paste0('http://127.0.0.1:8000/cursos_tecnicos?regiao=', regiao, '&estado=', estado, '&municipio=', municipio, '&periodo=', periodo)
    return(micr_educ_url)
  }
  
  # Ensino Superior - Instituicoes de Ensino Superior
  if(type == 'ens_sup_ies'){
    micr_educ_url = paste0('http://127.0.0.1:8000/ies?regiao=', regiao, '&estado=', estado, '&municipio=', municipio, '&periodo=', periodo)
    return(micr_educ_url)
  }
  
  # Ensino Superior - Cursos
  if(type == 'ens_sup_cur'){
    micr_educ_url = paste0('http://127.0.0.1:8000/cursos?regiao=', regiao, '&estado=', estado, '&municipio=', municipio, '&periodo=', periodo)
  }
}