import psutil
import time
from datetime import datetime
from mysql.connector import connect, Error

# Configurações de conexão com o banco de dados
config = {
    'user': 'root',
    'password': '#Gf38851238863',
    'host': '127.0.0.1',
    'database': 'HardStock'
}
    

def capturar_dados(cursor):
    # Capturando o tempo
    data_hora = datetime.now()

    # CPU
    porc_cpu = psutil.cpu_percent()
    cpu_freq = psutil.cpu_freq().current
    cpu_times = psutil.cpu_times()
    tempo_ativo = cpu_times.user + cpu_times.system

    # Disco
    uso_disco = psutil.disk_usage('/')
    io_counters = psutil.disk_io_counters()

    # Memória RAM
    mem = psutil.virtual_memory()

    # Inserindo dados na tabela Capturas
    componentes = {
        'Uso da CPU': porc_cpu,
        'Velocidade da CPU': cpu_freq,
        'Tempo Ativo da CPU': tempo_ativo,
        'Uso do Disco Total': uso_disco.total / (1024**3),  # em GB
        'Uso do Disco Usado': uso_disco.used / (1024**3),  # em GB
        'Uso do Disco Livre': uso_disco.free / (1024**3),  # em GB
        'Porcentagem de Disco Usado': uso_disco.percent,
        'Tempo de Leitura do Disco': io_counters.read_time,
        'Tempo de Gravação do Disco': io_counters.write_time,
        'Memória Total': mem.total / (1024**3),  # em GB
        'Memória Disponível': mem.available / (1024**3),  # em GB
        'Porcentagem de Memória Usada': mem.percent,
        'Memória Usada': mem.used / (1024**3),  # em GB
    }

    for nome, valor in componentes.items():
        query = """
            INSERT INTO Capturas (data_hora, valor, fkComponente, fkServidor)
            VALUES (%s, %s, (SELECT idComponente FROM Componentes WHERE nome = %s), 1)
        """
        values = (data_hora, valor, nome)

        try:
            cursor.execute(query, values)
            print(f"Registro de '{nome}' inserido na tabela Capturas.")
        except Exception as e:
            print(f"Erro ao inserir dados de '{nome}': {e}")

try:
    db = connect(**config)
    if db.is_connected():
        db_info = db.get_server_info()
        print('Connected to MySQL server version -', db_info)

        # Loop para capturar dados continuamente
        while True:
            with db.cursor() as cursor:
                capturar_dados(cursor)
                db.commit()  # Commit após capturar os dados

            # Pausa antes da próxima captura
            time.sleep(20)

except Error as e:
    print('Error to connect with MySQL -', e)
finally:
    if db.is_connected():
        db.close()
