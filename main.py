import mysql.connector

# conectar com o banco de dados
connection = mysql.connector.connect(
  host="localhost",
  user="user",
  password="password",
  database="db_obras"
)

# executa uma inserção no banco
cursor = connection.cursor()

cursor.execute("INSERT INTO funcionarios_prefeitura_cargos VALUES (%s, %s)", (1, "Dilermando"))
cursor.execute("INSERT INTO funcionarios_prefeitura_cargos VALUES (%s, %s)", (2, "Raquel"))
cursor.execute("INSERT INTO funcionarios_prefeitura_cargos VALUES (%s, %s)", (3, "Guilherme"))

connection.commit()

# executa uma consulta no banco
cursor = connection.cursor()
cursor.execute("SELECT * FROM funcionarios_prefeitura_cargos")
result = cursor.fetchall()

# exibe em tela os resultados
for x in result:
    print(x)
