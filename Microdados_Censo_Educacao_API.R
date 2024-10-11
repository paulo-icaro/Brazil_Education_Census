# ================================================================= #
# === API - MICRODADOS DO CENSO DA EDUCAÇÃO (BASICA E SUPERIOR) === #
# ================================================================= #

# --- Script por Paulo Icaro --- #

# Plumber Website: https://www.rplumber.io/
# Tutoriais:
# i - https://icaroagostino.github.io/post/plumber/
# ii - https://www.appsilon.com/post/r-rest-api
# iii - https://posit.co/blog/creating-apis-for-data-science-with-plumber/



# ====================== #
# === 1. Bibliotecas === #
# ====================== #
library(plumber)
library(dplyr)



# ===================== #
# === 2. Microdados === #
# ===================== #

# Educacao Basica
micr_educacao_basica = read.delim(file = 'Microdados/Microdados - Censo Escolar (2023)/dados/microdados_ed_basica_2023.csv', sep = ';', fileEncoding = 'LATIN1')
micr_cursos_tecnicos = read.delim(file = 'Microdados/Microdados - Censo Escolar (2023)/dados/suplemento_cursos_tecnicos_2023.csv', sep = ';', fileEncoding = 'LATIN1')

# Educacao Superior
micr_ensino_superior = read.delim(file = 'Microdados/Microdados - Censo Ensino Superior (2022)/dados/MICRODADOS_ED_SUP_IES_2022.CSV', sep = ';', fileEncoding = 'LATIN1')
micr_cursos_ies = read.delim(file = 'Microdados/Microdados - Censo Ensino Superior (2022)/dados/MICRODADOS_CADASTRO_CURSOS_2022.CSV', sep = ';', fileEncoding = 'LATIN1')



# ============== #
# === 3. API === #
# ============== #
#* @apiTitle Microdados do Censo do Ensino Básico e Superior
#* @apiDescription Este API disponibiliza os dados do censo da educação básica e superior publicados pelo INEP.
#* @apiVersion 1.0.0


# --------------------------- #
# --- 3.1 Tags Principais --- #
# --------------------------- #
# Observacao: 
# i) Nao esquecer de associar os elementos @apiTag com @tag, a nao ser que queira deixar a nomenclatura com o nome default
# ii) O nome da tag so pode se escrito entre aspas se a descricao for adicionada na sequencia. Caso contrario a formatacao ficara desorganizada
#* @apiTag "Censo da Educacao Basica" Acesso aos microdados do ensino basico
#* @apiTag "Censo da Educacao Superior" Acesso aos microdados do ensino superior


# -------------------------------------- #
# --- 3.2 Tags Secundarias + Funcoes --- #
# -------------------------------------- #

# --- 3.2.1 Tag - Censo da Educacao Basica - Educacao Basica --- #
#* @tag "Censo da Educacao Basica"
#* @get /educacao_basica
#* @serializer unboxedJSON list(na = "null")
#* @param regiao Informe a regiao (Ex: Norte)
#* @param estado Informe a sigla UF (Ex: AM)
#* @param municipio Informe codigo cidade (Ex: 1302603 - Manaus)
#* @param periodo Informe o periodo

# --- 3.2.1 Funcao - Censo da Educacao Basica - Educacao Basica --- #
function(regiao, estado, municipio, periodo = '2023'){
  micr_educacao_basica %>% filter(NO_REGIAO == regiao, SG_UF == estado, CO_MUNICIPIO == municipio, NU_ANO_CENSO == periodo)
}


# --- 3.2.2 Tag - Censo da Educacao Basica - Cursos Tecnicos --- #
#* @tag "Censo da Educacao Basica"
#* @get /cursos_tecnicos
#* @serializer unboxedJSON list(na = "null")
#* @param regiao Informe a regiao (Ex: Nordeste)
#* @param estado Informe a sigla UF (Ex: CE)
#* @param municipio Informe codigo cidade (Ex: 2304400 - Fortaleza)
#* @param periodo Informe o periodo

# --- 3.2.2 Funcao - Censo da Educacao Basica - Cursos Tecnicos --- #
function(regiao, estado, municipio, periodo = '2023'){
  micr_cursos_tecnicos %>% filter(NO_REGIAO == regiao, SG_UF == estado, CO_MUNICIPIO == municipio, NU_ANO_CENSO == periodo)
}


# --- 3.2.3 Tag - Censo da Educacao Superior - Ensino Superior
#* @tag "Censo da Educacao Superior"
#* @get /ensino_superior
#* @serializer unboxedJSON list(na = "null")
#* @param regiao Informe a regiao (Ex: Norte)
#* @param estado Informe a sigla UF (Ex: AM)
#* @param municipio Informe codigo cidade (Ex: 1302603 - Manaus)
#* @param periodo Informe o periodo

# --- 3.2.3 Funcao - Microdados da Educacao Superior - Ensino Superior --- #
function(regiao, estado, municipio, periodo = '2022'){
  micr_ensino_superior %>% filter(NO_REGIAO_IES == regiao, SG_UF_IES == estado, CO_MUNICIPIO_IES == municipio, NU_ANO_CENSO == periodo)
}


# --- 3.2.4 Tag - Censo da Educacao Superior - Cursos --- #
#* @tag "Censo da Educacao Superior"
#* @get /cursos
#* @serializer unboxedJSON list(na = "null")
#* @param regiao Informe a regiao (Ex: Nordeste)
#* @param estado Informe a sigla UF (Ex: CE)
#* @param municipio Informe codigo cidade (Ex: 2304400 - Fortaleza)
#* @param periodo Informe o periodo

# --- 3.2.4 Funcao - Censo da Educacao Superior - Instituicoes --- #
function(regiao, estado, municipio, periodo = '2022'){
  micr_cursos_ies %>% filter(NO_REGIAO == regiao, SG_UF == estado, CO_MUNICIPIO == municipio, NU_ANO_CENSO == periodo)
}





# ------------------------ #
# --- Execute this API --- #
# ------------------------ #
# pr('Microdados_Censo_Educacao_API.R') %>% pr_run(port = 8000)