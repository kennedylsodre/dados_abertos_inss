#%%
import matplotlib.pyplot as plt
import seaborn as sns 
# %%
custo_fixo = 15000 
custo_cliente = 50
receita_cliente = 150 
margem_contribuicao = (receita_cliente-custo_cliente)/receita_cliente
ponto_equilibrio = custo_fixo/margem_contribuicao
ponto_equilibrio_clientes = ponto_equilibrio/receita_cliente
#%%
num_clientes = [i for i in range(0,250,25)]
custos = []
receitas = []
for cliente in num_clientes:
    custo = custo_fixo + (custo_cliente*cliente)
    receita = receita_cliente*cliente
    custos.append(custo)
    receitas.append(receita)
# %%
plt.rcParams['font.family'] = 'Lucida Sans'
plt.rcParams['font.size'] = 12

# Gera o gráfico
plt.figure(figsize=(10,6))
plt.plot(num_clientes, custos, label='Custos Totais', color='#BC0E0E')
plt.plot(num_clientes, receitas, label='Receitas Totais', color='#0F1FBB')
plt.axvline(ponto_equilibrio_clientes, color='#656565', linestyle='--', label='Ponto de Equilíbrio')
plt.xlabel('Número de Clientes')
plt.ylabel('R$')
plt.title('Ponto de Equilíbrio',fontsize=16)
plt.legend()
plt.tight_layout()
plt.show()
# %%
import matplotlib.pyplot as plt
import numpy as np

# Define o estilo da fonte
plt.rcParams['font.family'] = 'Lucida Sans'
plt.rcParams['font.size'] = 12

# Gera o gráfico
plt.figure(figsize=(10,6))

# Converte os dados para arrays do NumPy
num_clientes_np = np.array(num_clientes)
custos_np = np.array(custos)
receitas_np = np.array(receitas)

# Sombreamento (sem labels para não aparecer na legenda)
plt.fill_between(
    num_clientes_np,
    custos_np,
    receitas_np,
    where=(num_clientes_np < ponto_equilibrio_clientes),
    interpolate=True,
    color='salmon',
    alpha=0.3
)

plt.fill_between(
    num_clientes_np,
    custos_np,
    receitas_np,
    where=(num_clientes_np >= ponto_equilibrio_clientes),
    interpolate=True,
    color='lightgreen',
    alpha=0.3
)

# Linhas principais
plt.plot(num_clientes, custos, label='Custos Totais', color='#BC0E0E')
plt.plot(num_clientes, receitas, label='Receitas Totais', color='#0F1FBB')
plt.axvline(ponto_equilibrio_clientes, color='#656565', linestyle='--', label='Ponto de Equilíbrio')

# Labels e título
plt.xlabel('Número de Clientes',fontsize = 14)
plt.ylabel('R$',fontsize=14)
plt.title('Ponto de Equilíbrio',fontsize = 20)

# Remove as bordas superior e direita
ax = plt.gca()
ax.spines['top'].set_visible(False)
ax.spines['right'].set_visible(False)

# Finalização
plt.legend()
plt.tight_layout()
plt.show()

# %%
