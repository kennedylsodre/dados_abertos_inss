SELECT 
  des_comp_mun_resid cidade_residencia
  ,cod_municipio_resid codigo_municipio_residencia
  ,des_uf_resid uf_residencia
  ,des_municipio_resid municipio_residencia
  ,count(*) quantidade_beneficios_concedidos

FROM `inss-case.beneficios_inss.concessao_beneficios`
WHERE des_comp_mun_resid <> '00000-Zerada'
GROUP BY 1,2,3,4
ORDER BY 5 DESC
LIMIT 30
