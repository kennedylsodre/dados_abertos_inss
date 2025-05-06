with cidades as (

SELECT 
  des_comp_mun_resid cidade_residencia
  ,count(*) quantidade_beneficios_concedidos

FROM `inss-case.beneficios_inss.concessao_beneficios`
WHERE des_comp_mun_resid <> '00000-Zerada' and
date_trunc(dat_inicio_beneficio,month) >= date(2025,01,01) and date_trunc(dat_inicio_beneficio,month) <= date(2025,03,01)
GROUP BY 1
ORDER BY 2 DESC
LIMIT 30 ) 

,qtd_mes as (
SELECT 
  ben.des_comp_mun_resid cidade_residencia
  ,cod_municipio_resid codigo_municipio_residencia
  ,des_uf_resid uf_residencia
  ,des_municipio_resid municipio_residencia
  ,date_trunc(dat_inicio_beneficio,month) dat_inicio_beneficio
  ,count(*) quantidade_beneficios_concedidos

FROM `inss-case.beneficios_inss.concessao_beneficios` ben 
INNER JOIN cidades 
  on ben.des_comp_mun_resid = cidades.cidade_residencia
WHERE date_trunc(dat_inicio_beneficio,month) >= date(2025,01,01) and date_trunc(dat_inicio_beneficio,month) <= date(2025,03,01)
GROUP BY 1,2,3,4,5
) 


SELECT 
  cidade_residencia
  ,codigo_municipio_residencia
  ,uf_residencia
  ,municipio_residencia
  ,avg(quantidade_beneficios_concedidos) as media_beneficios_concedidos
  , ((15000/((150-50)/150)) / 150) / avg(quantidade_beneficios_concedidos) Tempo_ponto_de_equilibrio
  ,100000 / ((avg(quantidade_beneficios_concedidos)*150-(15000 + avg(quantidade_beneficios_concedidos) * 50)))  payback_simples_meses
FROM qtd_mes
GROUP BY 1,2,3,4

