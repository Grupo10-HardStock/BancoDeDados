-- Criando a base de dados HardStock
CREATE DATABASE IF NOT EXISTS HardStock;

-- Usando a base de dados criada
USE HardStock;

-- Tabela Funcionario para armazenar dados dos funcionários
CREATE TABLE IF NOT EXISTS Funcionario (
    idFuncionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    sobrenome VARCHAR(100),
    numeroTelefone char(16),
    email VARCHAR(256),
    senha VARCHAR(256),	
    permissao VARCHAR(45),
    fkEmpresa INT,
    estado varchar(45) default "Ativo"
  );

-- Inserindo um registro na tabela Funcionario
INSERT INTO Funcionario (nome, sobrenome, numeroTelefone, email, senha, permissao)
VALUES ('João', 'Silva', '(11) 91234-5678', 'joao.silva@empresa.com', 'senhaSegura123', 'Hardstock');

-- Tabela Empresa para armazenar informações da empresa
CREATE TABLE IF NOT EXISTS Empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    razaoSocial VARCHAR(256),
    cnpj CHAR(20),
	estado varchar(45) default "Ativo",
    emailCorporativo VARCHAR(256)
);
select * from Empresa;
-- Inserindo um registro na tabela Empresa, relacionando com Funcionario
INSERT INTO Empresa (razaoSocial, cnpj, emailCorporativo)
VALUES ('Tech Solutions Ltda', '00.123.456/0001-23', 'contato@techsolutions.com');

-- Tabela Especificacoes para armazenar detalhes técnicos de servidores
CREATE TABLE IF NOT EXISTS Servidor (
    idServidor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    rede VARCHAR(50),
    ram VARCHAR(20),
    disco VARCHAR(20),
    cpu_ VARCHAR(20),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

-- Tabela Componentes para definir o tipo de componente e unidade de medida
CREATE TABLE IF NOT EXISTS Componentes (
    idComponente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL, -- Nome do componente (e.g., CPU Uso, Memória RAM)
    unidadeMedida VARCHAR(20) NOT NULL -- Unidade de medida (e.g., %, GB)
);


INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Bytes Enviados', 'MB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Bytes Recebidos', 'MB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Uso da CPU', '%');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Uso do Disco Total', 'GB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Uso do Disco Usado', 'GB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Tempo de Leitura do Disco', 'ms');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Memória Total', 'GB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Memória Usada', 'GB');


-- Tabela Capturas para armazenar os valores capturados de componentes
CREATE TABLE IF NOT EXISTS Capturas (
    idCaptura INT AUTO_INCREMENT PRIMARY KEY,
    data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Data e hora da captura
    valor FLOAT NOT NULL, -- Valor capturado (e.g., 75.5)
    fkComponente INT, -- Referência ao componente capturado
    fkServidor INT, -- Referência ao servidor
    FOREIGN KEY (fkComponente) REFERENCES Componentes(idComponente),
    FOREIGN KEY (fkServidor) REFERENCES Servidor(idServidor)
);

-- Inserindo capturas para monitoramento dos componentes em dois servidores
INSERT INTO Capturas (data_hora, valor, fkComponente, fkServidor) VALUES
('2024-11-05 09:00:00', 35.2, 1, 1),
('2024-11-05 09:01:00', 36.8, 1, 1),
('2024-11-05 09:02:00', 33.5, 1, 1),
('2024-11-05 09:03:00', 40.1, 1, 1),
('2024-11-05 09:04:00', 45.6, 1, 1),
('2024-11-05 09:05:00', 50.0, 1, 1),
('2024-11-05 09:06:00', 55.3, 1, 1),
('2024-11-05 09:07:00', 60.7, 1, 1),
('2024-11-05 09:08:00', 65.2, 1, 1),
('2024-11-05 09:09:00', 70.1, 1, 1),

('2024-11-05 09:00:00', 8.5, 2, 1),
('2024-11-05 09:01:00', 8.2, 2, 1),
('2024-11-05 09:02:00', 7.9, 2, 1),
('2024-11-05 09:03:00', 8.1, 2, 1),
('2024-11-05 09:04:00', 8.0, 2, 1),
('2024-11-05 09:05:00', 8.3, 2, 1),
('2024-11-05 09:06:00', 7.8, 2, 1),
('2024-11-05 09:07:00', 8.6, 2, 1),
('2024-11-05 09:08:00', 8.4, 2, 1),
('2024-11-05 09:09:00', 8.7, 2, 1),

('2024-11-05 09:00:00', 120.5, 3, 1),
('2024-11-05 09:01:00', 121.0, 3, 1),
('2024-11-05 09:02:00', 119.9, 3, 1),
('2024-11-05 09:03:00', 122.3, 3, 1),
('2024-11-05 09:04:00', 121.4, 3, 1),
('2024-11-05 09:05:00', 119.7, 3, 1),
('2024-11-05 09:06:00', 120.8, 3, 1),
('2024-11-05 09:07:00', 121.2, 3, 1),
('2024-11-05 09:08:00', 120.3, 3, 1),
('2024-11-05 09:09:00', 119.6, 3, 1),

('2024-11-05 09:00:00', 52.3, 4, 2),
('2024-11-05 09:01:00', 53.1, 4, 2),
('2024-11-05 09:02:00', 51.8, 4, 2),
('2024-11-05 09:03:00', 54.0, 4, 2),
('2024-11-05 09:04:00', 53.7, 4, 2),
('2024-11-05 09:05:00', 52.2, 4, 2),
('2024-11-05 09:06:00', 54.3, 4, 2),
('2024-11-05 09:07:00', 53.9, 4, 2),
('2024-11-05 09:08:00', 52.7, 4, 2),
('2024-11-05 09:09:00', 54.1, 4, 2),

('2024-11-05 09:00:00', 30.2, 5, 2),
('2024-11-05 09:01:00', 29.9, 5, 2),
('2024-11-05 09:02:00', 31.0, 5, 2),
('2024-11-05 09:03:00', 30.7, 5, 2),
('2024-11-05 09:04:00', 30.5, 5, 2),
('2024-11-05 09:05:00', 31.1, 5, 2),
('2024-11-05 09:06:00', 30.4, 5, 2),
('2024-11-05 09:07:00', 30.8, 5, 2),
('2024-11-05 09:08:00', 30.1, 5, 2),
('2024-11-05 09:09:00', 31.2, 5, 2),

('2024-11-05 09:00:00', 25.1, 6, 2),
('2024-11-05 09:01:00', 24.8, 6, 2),
('2024-11-05 09:02:00', 25.5, 6, 2),
('2024-11-05 09:03:00', 25.2, 6, 2),
('2024-11-05 09:04:00', 24.9, 6, 2),
('2024-11-05 09:05:00', 25.6, 6, 2),
('2024-11-05 09:06:00', 25.0, 6, 2),
('2024-11-05 09:07:00', 25.3, 6, 2),
('2024-11-05 09:08:00', 24.7, 6, 2),
('2024-11-05 09:09:00', 25.4, 6, 2);

    

-- Tabela Alertas para registrar alertas associados às capturas
CREATE TABLE IF NOT EXISTS Alertas (
    idAlerta INT AUTO_INCREMENT PRIMARY KEY,
    fkCaptura INT,
    gravidade ENUM('baixo', 'médio', 'alto', 'critico'),
    descricao VARCHAR(256),
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (fkCaptura) REFERENCES Capturas(idCaptura)
);
 
alter table Funcionario add constraint ligacao foreign key (fkEmpresa) references Empresa(idEmpresa);

 CREATE
DEFINER=CURRENT_USER SQL SECURITY INVOKER
VIEW VizFunc AS
SELECT idFuncionario,nome,sobrenome,email,fkEmpresa,estado FROM Funcionario;

 CREATE
DEFINER=CURRENT_USER SQL SECURITY INVOKER
VIEW VizEdit AS
SELECT idFuncionario,nome,numeroTelefone, senha, permissao, estado FROM Funcionario;
