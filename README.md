
# 📊 Estudo de Oportunidades de Negócio com Dados do INSS

Este projeto explora dados públicos do INSS para identificar cidades estratégicas para expansão de agências físicas e viabilidade de um novo produto de crédito voltado a beneficiários.

---

## 📁 Entregas

- 🖥️ **Dashboard Interativo**: [Acesse no Power BI](https://seulinkdopowerbi)
- 📽️ **Apresentação dos Resultados**: [Veja o PPT no Google Drive](https://seulinkdoppt)

---

## 🎯 Objetivos

- Identificar as 30 cidades com maior potencial de novos beneficiários do INSS
- Estimar a viabilidade financeira da abertura de agências
- Simular tempo de retorno financeiro (breakeven)
- Propor e testar um produto de crédito com segmentação demográfica

---

## 🔍 Dados Utilizados

Fonte: [Dados abertos do INSS](https://dados.gov.br/dados/conjuntos-dados/beneficios-concedidos-plano-de-dados-abertos-jun-2023-a-jun-2025)  
Período analisado: Janeiro a Março de 2025

---

## 🛠️ Tecnologias

- Python (Pandas, NumPy, Matplotlib)
- Google Cloud (Bigquery)
- Power BI
- Excel
- Power Point

---

## 💰 Cálculo do Ponto de Equilíbrio (Breakeven)

Para avaliar a viabilidade financeira da abertura de agências físicas, foi realizada uma simulação baseada no modelo de **ponto de equilíbrio mensal** e **tempo de retorno do investimento**.

### 🧾 Premissas Utilizadas

| Descrição                   | Valor               |
|----------------------------|---------------------|
| Investimento Inicial       | R$ 100.000,00       |
| Custo Fixo Mensal          | R$ 15.000,00        |
| Custo Variável por Cliente | R$ 50,00            |
| Receita Média por Cliente  | R$ 150,00           |

---

### 📉 Fórmula do Ponto de Equilíbrio Mensal

O ponto de equilíbrio ocorre quando:

```
Receita Total = Custos Totais
```

Como a **receita por cliente** é de R$ 150,00 e o **custo variável** é R$ 50,00 por cliente, o **lucro bruto por cliente** é:

```
Lucro por cliente = 150 - 50 = R$ 100,00
```

Portanto, o número de clientes necessário para cobrir os custos fixos é:

```
Clientes para breakeven mensal = 15.000 / 100 = 150 clientes
```

---

## 👤 Sobre o Projeto

Estudo realizado para praticar ingestão, tratamento e visualização de dados, utilizando:

- Análise de dados públicos
- Modelagem financeira
- Visualização interativa
- Comunicação de resultados

---

## 📬 Contato

**[Kennedy Lacerda Sodre]**  
[LinkedIn](https://www.linkedin.com/in/kennedylacerda/) | [E-mail](mailto:klacerda88@gmail.com)
