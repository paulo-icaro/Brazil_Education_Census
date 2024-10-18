# ==================================================================== #
# === COLETA - MICRODADOS DO CENSO DA EDUCAÇÃO (BASICA E SUPERIOR) === #
# ==================================================================== #

# --- Script by Paulo Icaro --- #


# ------------------- #
# --- Bibliotecas --- #
# ------------------- #
source('https://raw.githubusercontent.com/paulo-icaro/Censo_Educacao/refs/heads/main/Microdados_Censo_Educacao_URL.R')
source('https://raw.githubusercontent.com/paulo-icaro/Censo_Educacao/refs/heads/main/Microdados_Censo_Educacao_Acesso.R')

# source('C:/Users/Paulo/Documents/Repositorios/Censo_Educacao/Microdados_Censo_Educacao_URL.R')
# source('C:/Users/Paulo/Documents/Repositorios/Censo_Educacao/Microdados_Censo_Educacao_Acesso.R')



# ----------------------------------------------- #
# --- Tabela de Regioes, Estados e Municipios --- #
# ----------------------------------------------- #
localities = read.csv(file = 'https://raw.githubusercontent.com/paulo-icaro/Ibge_API/main/Tabela_(Regioes_Estados_Municipios).csv', header = TRUE, sep = ';', fileEncoding = 'LATIN1')
localities = localities %>% filter(Cod_Estado == 23)

micr_educ_bas_ceara = micr_ens_tec_ceara = micr_ens_sup_ceara = micr_ies_sup_ceara = NULL


# Ceara
for(i in localities$Cod_Municipio){
    micr_ens_bas = microdados_educacao_api(url = microdados_educacao_url('ens_bas', 'Nordeste', 'CE', i, '2023'), message = FALSE)[c(1:8, 18:20, 31, 286, 287, 302, 320, 321, 325)]
    micr_ens_tec = microdados_educacao_api(url = microdados_educacao_url('ens_tec', 'Nordeste', 'CE', i, '2023'), message = FALSE)[c(1:8, 11:19)]
    micr_ens_sup_ies = microdados_educacao_api(url = microdados_educacao_url('ens_sup_ies', 'Nordeste', 'CE', i, '2022'), message = FALSE)[c(1:9, 14:20)]
    micr_ens_sup_curso = microdados_educacao_api(url = microdados_educacao_url('ens_sup_cur', 'Nordeste', 'CE', i, '2022'), message = FALSE)[c(1:9, 11:18, 25, 29:30, 38, 46, 76, 95)]

    micr_ens_bas_ceara = rbind(micr_ens_bas_ceara, micr_ens_bas)
    micr_ens_tec_ceara = rbind(micr_ens_tec_ceara, micr_ens_tec)
    micr_ens_sup_ies_ceara = rbind(micr_ens_sup_ies_ceara, micr_ens_sup_ies)
    micr_ens_sup_curso_ceara = rbind(micr_ies_sup_cur_ceara, micr_ens_sup_curso)
    
    if(i == last(x = localities$Cod_Municipio)){
      rm(micr_ens_bas, micr_ens_tec, micr_ens_sup_ies, micr_ens_sup_curso)
    }
}