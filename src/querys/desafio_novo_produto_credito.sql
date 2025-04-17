with cidades as (

SELECT 
  des_comp_mun_resid cidade_residencia
  ,count(*) quantidade_beneficios_concedidos

FROM `mercantil-case.beneficios_inss.concessao_beneficios`
WHERE des_comp_mun_resid <> '00000-Zerada' and
date_trunc(dat_inicio_beneficio,month) >= date(2025,01,01) and date_trunc(dat_inicio_beneficio,month) <= date(2025,03,01)
GROUP BY 1
ORDER BY 2 DESC
LIMIT 30 ),

tb_idades as (
SELECT 
  ben.des_comp_mun_resid cidade_residencia
  ,cod_municipio_resid codigo_municipio_residencia
  ,des_uf_resid uf_residencia
  ,des_municipio_resid municipio_residencia
  ,des_sexo 
  ,dat_nascimento
  ,date_diff(current_Date(),dat_nascimento,year) idade
  ,case 
    when des_sexo = 'Masculino' and date_diff(current_Date(),dat_nascimento,year) <= 60 then 'Masculino até 60 anos'
    when des_sexo = 'Masculino' and date_diff(current_Date(),dat_nascimento,year) <= 70 then 'Masculino até 70 anos'
    when des_sexo = 'Masculino' and date_diff(current_Date(),dat_nascimento,year) <= 80 then 'Masculino até 80 anos'
    when des_sexo = 'Feminino' and date_diff(current_Date(),dat_nascimento,year) <= 60 then 'Feminino até 60 anos'
    when des_sexo = 'Feminino' and date_diff(current_Date(),dat_nascimento,year) <= 70 then 'Feminino até 70 anos'
    when des_sexo = 'Feminino' and date_diff(current_Date(),dat_nascimento,year) <= 80 then 'Feminino até 80 anos'
    when des_sexo = 'Feminino' and date_diff(current_Date(),dat_nascimento,year) <= 85 then 'Feminino até 85 anos'
    end tipo_beneficiario
FROM `mercantil-case.beneficios_inss.concessao_beneficios` ben 
INNER JOIN cidades 
  on ben.des_comp_mun_resid = cidades.cidade_residencia
WHERE date_trunc(dat_inicio_beneficio,month) >= date(2025,01,01) and date_trunc(dat_inicio_beneficio,month) <= date(2025,03,01) 
and ben.des_Especie not like '%Auxilio%'
),

tb_produto as (
SELECT 
   cidade_residencia
  ,codigo_municipio_residencia
  ,uf_residencia
  ,municipio_residencia
  ,tipo_beneficiario
  ,count(*) qtd_beneficiarios 
  ,count(*)*0.2 publico_produto
  ,case  
      when tipo_beneficiario =  'Masculino até 60 anos'   then (20000*pow((1+0.016),30))
      when tipo_beneficiario =  'Masculino até 70 anos'   then (15000*pow((1+0.016),30))
      when tipo_beneficiario =  'Masculino até 80 anos'   then (10000*pow((1+0.016),30))
      when tipo_beneficiario =  'Feminino até 60 anos'    then (20000*pow((1+0.016),30))
      when tipo_beneficiario =  'Feminino até 70 anos'    then (10000*pow((1+0.016),30))
      when tipo_beneficiario =  'Feminino até 80 anos'    then (10000*pow((1+0.016),30))
      when tipo_beneficiario =  'Feminino até 85 anos'    then (5000*pow((1+0.016),30))    
  ELSE null end as valor_total_produto_por_cliente
  ,case  
      when tipo_beneficiario =  'Masculino até 60 anos'   then 20000
      when tipo_beneficiario =  'Masculino até 70 anos'   then 15000
      when tipo_beneficiario =  'Masculino até 80 anos'   then 10000
      when tipo_beneficiario =  'Feminino até 60 anos'    then 20000
      when tipo_beneficiario =  'Feminino até 70 anos'    then 10000
      when tipo_beneficiario =  'Feminino até 80 anos'    then 10000
      when tipo_beneficiario =  'Feminino até 85 anos'    then 5000 
  ELSE null end as valor_concedido_produto_por_cliente
  ,case  
      when tipo_beneficiario =  'Masculino até 60 anos'   then (20000*0.016)
      when tipo_beneficiario =  'Masculino até 70 anos'   then (15000*+0.016)
      when tipo_beneficiario =  'Masculino até 80 anos'   then (10000*0.016)
      when tipo_beneficiario =  'Feminino até 60 anos'    then (20000*0.016)
      when tipo_beneficiario =  'Feminino até 70 anos'    then (10000*0.016)
      when tipo_beneficiario =  'Feminino até 80 anos'    then (10000*0.016)
      when tipo_beneficiario =  'Feminino até 85 anos'    then (5000*0.016)    
  ELSE null end as valor_receita_produto_primeiro_mes
FROM tb_idades
GROUP BY 1,2,3,4,5 )

SELECT 
  tipo_beneficiario
  ,sum(qtd_beneficiarios) publico_total
  ,sum(publico_produto ) publico_total_produto
  ,SUM(valor_concedido_produto_por_cliente*publico_produto) credito_concedido
  ,sum(publico_produto * valor_receita_produto_primeiro_mes) receita_total_primeiro_mes
  ,sum(publico_produto*0.95*valor_total_produto_por_cliente) receita_total
  ,sum(publico_produto*0.95*valor_total_produto_por_cliente) - sum(publico_produto*valor_concedido_produto_por_cliente) as lucro_total
FROM tb_produto
GROUP BY 1
ORDER BY 1