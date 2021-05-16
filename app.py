import mysql.connector

connection = mysql.connector.connect(
  host="localhost",
  user="user",
  password="password",
  database="db_obras"
)

# 4. a. 
# Uma consulta que deve retornar para cada bairro as obras 
# sugeridas e a indicação daquelas que foram selecionadas pela 
# comissão da prefeitura. Nesta consulta deve ser apresentado 
# descrição da obra, sua categoria, a prioridade, previsão de 
# início e término, valor estimado. Se a obra for uma selecionada 
# pela comissão, deve mostrar o CREA e nome do engenheiro responsável,
# e aquantidade de vistorias realizadas.

cursor = connection.cursor()

cursor.execute("""
select 
  associacoes_bairros.bairro,
  (case when obras.situacao != 2 then 'Sim' else 'Não' end) escolhida_pela_prefeitura,
	obras.descricao descricao_obra,
	obras_segmentos.nome categoria,
	obras_niveis_prioridade.nome prioridade,
	obras.data_previsao_inicio,
	obras.data_previsao_termino,
	obras.valor_estimado,
	engenheiros.crea engenheiro_responsavel_crea,
	engenheiros.nome engenheiro_responsavel_nome,
	(select count(*) from obras_vistorias where obra = obras.codigo) quantidade_vistorias
from associacoes_bairros
inner join obras on obras.associacao_bairro_idealizadora = associacoes_bairros.codigo
inner join obras_situacoes on obras_situacoes.codigo = obras.situacao
inner join obras_segmentos on obras_segmentos.codigo = obras.segmento
left join engenheiros on engenheiros.crea = obras.engenheiro_responsavel 
inner join obras_niveis_prioridade on obras_niveis_prioridade.codigo = obras.prioridade;
""")

result = cursor.fetchall()

for x in result:
    print("Bairro: " + x[0])
    print("Escolhida pela prefeitura: " + x[1])
    print("Descrição da obra: " + x[2])
    print("Categoria: " + x[3])
    print("Prioridade: " + x[4])
    print("Data prevista para início: " + x[5].strftime('%d/%m/%Y'))
    print("Data prevista para término: " + x[6].strftime('%d/%m/%Y'))
    print("Valor estimado: R$" + str(x[7]).replace(".", ","))
    if (x[8] is not None):
      print("CREA do engenheiro(a) responsável: " + x[8])
      print("Nome do engenheiro(a) responsável: " + x[9])
      print("Quantidade de vistorias: " + str(x[10]))

    print("\n")

print("----------------------------------------------")

# 4. b. 
# Uma consulta que deve apresentar para cada bairro a quantidade 
# de obras realizadas por segmento e o valor total dessas obras em 
# cada ano.

cursor = connection.cursor()

cursor.execute("""
select 
	associacoes_bairros.bairro, 
	obras_segmentos.nome segmento,
	YEAR(obras.data_previsao_inicio) ano,
	COUNT(obras.codigo) quantidade_de_obras, 
	SUM(obras.valor_estimado) valor_total_estimado
from associacoes_bairros
inner join obras on associacoes_bairros.codigo = obras.associacao_bairro_idealizadora
inner join obras_segmentos on obras.segmento = obras_segmentos.codigo
group by obras_segmentos.codigo, associacoes_bairros.codigo, YEAR(obras.data_previsao_inicio)
order by associacoes_bairros.bairro;
""")

result = cursor.fetchall()

for x in result:
  print("Bairro: " + x[0])
  print("Segmento: " + x[1])
  print("Ano: " + str(x[2]))
  print("Quantidade de obras: " + str(x[3]))
  print("Valor total estimado: R$" + str(x[4]).replace(".",","))

  print("\n")

print("----------------------------------------------")

# 4. c.
# Por fim, uma consulta que apresente as obras com mais de duas não 
# conformidades em suas vistorias. O resultado aparecer além da 
# quantidade de não conformidades, a descrição da obra, o segmento da 
# obra, o bairro, o nome do engenheiro principal responsável e o nome 
# da construtora.

cursor = connection.cursor()

cursor.execute("""
select obras.descricao descricao_obra, 
	(select COUNT(*) from obras_vistorias_inconformidades where vistoria in (
		select codigo from obras_vistorias where obra = obras.codigo)
	) quantidade_inconformidades,
	obras_segmentos.nome segmento,
	associacoes_bairros.bairro,
	engenheiros.nome,
	GROUP_CONCAT(construtoras.nome SEPARATOR ", ") construtora
from obras
inner join obras_segmentos on obras.segmento = obras_segmentos.codigo 
inner join associacoes_bairros on obras.associacao_bairro_idealizadora = associacoes_bairros.codigo 
inner join engenheiros on obras.engenheiro_responsavel = engenheiros.crea
inner join obras_contratos on obras.codigo = obras_contratos.numero_contrato
inner join obras_contratos_construtoras on obras_contratos.numero_contrato = obras_contratos_construtoras.numero_contrato
inner join construtoras on obras_contratos_construtoras.construtora = construtoras.cnpj 
where (
	select COUNT(*) from obras_vistorias_inconformidades where vistoria in (
		select codigo from obras_vistorias where obra = obras.codigo
	)
) > 2
group by obras.codigo;
""")

result = cursor.fetchall()

for x in result:
  print("Descrição da obra: " + x[0])
  print("Quantidade de inconformidades: " + str(x[1]))
  print("Segmento: " + x[2])
  print("Bairro: " + x[3])
  print("Nome do engenheiro(a) responsável: " + x[4])
  print("Construtora(s) responsável(eis): " + x[5])

  print("\n")

