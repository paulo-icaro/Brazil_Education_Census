# ==================================================================== #
# === COLETA - MICRODADOS DO CENSO DA EDUCAÇÃO (BASICA E SUPERIOR) === #
# ==================================================================== #

# --- Script by Paulo Icaro --- #


# ------------------- #
# --- Bibliotecas --- #
# ------------------- #
source('Microdados_Censo_Educacao_URL.R')
source('Microdados_Censo_Educacao_Acesso.R')



# ----------------------------------------------- #
# --- Tabela de Regioes, Estados e Municipios --- #
# ----------------------------------------------- #
localities = read.csv(file = 'https://raw.githubusercontent.com/paulo-icaro/Ibge_API/main/Tabela_(Regioes_Estados_Municipios).csv', header = TRUE, sep = ';', fileEncoding = 'LATIN1')
localities = localities %>% filter(Cod_Estado == 23)

micr_educ_bas_ceara = micr_ens_tec_ceara = micr_ens_sup_ceara = micr_ies_sup_ceara = NULL


# Ceara
for(i in localities$Cod_Municipio){
    micr_educ_bas = microdados_educacao_api(url = microdados_educacao_url('educ_bas', 'Nordeste', 'CE', i, '2023'))[c(1:8, 18:20, 31, 286, 287, 302, 320, 321, 325)]
    micr_ens_tec = microdados_educacao_api(url = microdados_educacao_url('ens_tec', 'Nordeste', 'CE', i, '2023'))[c(1:8, 11:19)]
    micr_ens_sup = microdados_educacao_api(url = microdados_educacao_url('ens_sup', 'Nordeste', 'CE', i, '2022'))[c(1:9, 14:20)]
    micr_ies_sup = microdados_educacao_api(url = microdados_educacao_url('ies_sup', 'Nordeste', 'CE', i, '2022'))[c(1:9, 11:18, 25, 29:30, 38, 46, 76, 95)]
    
    micr_educ_bas_ceara = rbind(micr_educ_bas_ceara, micr_educ_bas)
    micr_ens_tec_ceara = rbind(micr_ens_tec_ceara, micr_ens_tec)
    micr_ens_sup_ceara = rbind(micr_ens_sup_ceara, micr_ens_sup)
    micr_ies_sup_ceara = rbind(micr_ies_sup_ceara, micr_ies_sup)
    
    if(i == last(x = localities$Cod_Municipio)){
      rm(micr_educ_bas, micr_ens_tec, micr_ies_sup, micr_ens_sup)
    }
}