#%%
import os 
import pandas_gbq as gbq
import pandas as pd
#%%
def read_data(path_data):
    dfs = [ ]
    for file in os.listdir(path_data):
        df = pd.read_excel(os.path.join(path_data,file),skiprows=1)
        df = df.rename(columns={' Qt SM RMI ':'Qt SM RMI'})
        dfs.append(df)

    df_full = pd.concat(dfs)
    return df_full
#%%
def data_process(df,columns):

    df = df.rename(columns=columns)
    df['dat_Competencia_Concessao'] = pd.to_datetime(df['dat_Competencia_Concessao'].astype(str),format='%Y%m')
    df['dat_concessao_beneficio'] = pd.to_datetime(df['dat_concessao_beneficio'].apply(lambda x: None if x == '00/00/0000' else x))
    split_cols = df['des_comp_mun_resid'].str.split('-', n=2, expand=True)
    df['cod_municipio_resid'] = split_cols[0]
    df['des_uf_resid'] = split_cols[1]
    df['des_municipio_resid'] = split_cols[2] 
  
    for col in df.select_dtypes(include=['object']).columns:
        df[col] = df[col].astype(str)
    return df


#%% 
df_fulL = read_data('../data')

#%%
columns = {
'APS' : 'cod_APS'
,'APS.1' : 'desc_APS'
,'Competência concessão': 'dat_Competencia_Concessao'
,'Espécie':'cod_Especie'
,'Espécie.1':'des_Especie'
,'CID': 'cod_cid'
,'CID.1':'des_cid'
,'Despacho':'cod_despacho'
,'Despacho.1': 'des_despacho'
,'Dt Nascimento':'dat_nascimento'
,'Sexo.':'des_sexo'
,'Clientela':'des_cliente'
,'Mun Resid':'des_comp_mun_resid'
,'Vínculo dependentes':'des_vinculo_dependetes'
,'Forma Filiação':'des_forma_filiacao'
, 'UF':'des_UF'
,'Qt SM RMI':'qtd_salario_minimos_RMI'
,'Ramo Atividade':'des_ramo_atividade'
,'Dt DCB':'dat_concessao_beneficio'
,'Dt DDB':'dat_despacho_beneficio'
,'Dt DIB':'dat_inicio_beneficio'
,'País de Acordo Internacional':'des_classificao_acordo_internacional'
,'Classificador PA':'des_classificador_pa'} 

df_full_process = data_process(df_fulL,columns)
# %%
gbq.to_gbq(df_full_process,'beneficios_inss.concessao_beneficios',project_id='inss-case',if_exists='replace')
#%%
df_fulL['CID.1'].value_counts()
