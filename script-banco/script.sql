-- Criando a base de dados HardStock
CREATE DATABASE IF NOT EXISTS HardStock;

-- Usando a base de dados criada
USE HardStock;

select * from Funcionario;

-- Tabela Funcionario para armazenar dados dos funcionários
CREATE TABLE IF NOT EXISTS Funcionario (
    idFuncionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    sobrenome VARCHAR(100),
    numeroTelefone char(11),
    email VARCHAR(256),
    senha VARCHAR(256),
    permissao VARCHAR(45),
    fkAdministrador INT,
    fkEmpresa INT,
    fkHardStock VARCHAR(45) DEFAULT "NP",
    FOREIGN KEY (fkAdministrador) REFERENCES Funcionario(idFuncionario)
);
-- Inserindo um registro na tabela Funcionario
INSERT INTO Funcionario (nome, sobrenome, numeroTelefone, email, senha, permissao, fkAdministrador, fkHardStock)
VALUES ('João', 'Silva', 123456789, 'joao.silva@empresa.com', 'senhaSegura123', 'Adm', NULL, 'NP');

INSERT INTO Funcionario (nome, sobrenome, numeroTelefone, email, senha, permissao, fkAdministrador, fkHardStock)
VALUES ('eli', 'rufino', 123456789, 'eli.rufino@empresa.com', '123456', '1', NULL, 'NP');

-- Tabela Empresa para armazenar informações da empresa
CREATE TABLE IF NOT EXISTS Empresa (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    fkRepresentante INT DEFAULT NULL,
    razaoSocial VARCHAR(256),
    cnpj CHAR(14),
    emailCorporativo VARCHAR(256),
    FOREIGN KEY (fkRepresentante) REFERENCES Funcionario(idFuncionario)
);
select * from Empresa;
-- Inserindo um registro na tabela Empresa, relacionando com Funcionario
INSERT INTO Empresa (fkRepresentante, razaoSocial, cnpj, emailCorporativo)
VALUES (1, 'Tech Solutions Ltda', '12345678000195', 'contato@techsolutions.com');

-- Tabela Especificacoes para armazenar detalhes técnicos de servidores
CREATE TABLE IF NOT EXISTS Especificacoes (
    idEspecificacao INT AUTO_INCREMENT PRIMARY KEY,
    distribuicao VARCHAR(70),
    sistemaOperacional VARCHAR(50),
    processador VARCHAR(100),
    memoriaRam INT,
    qntDisco INT,
    placaRede VARCHAR(50)
);
-- Inserindo um registro na tabela Especificacoes
INSERT INTO Especificacoes (distribuicao, sistemaOperacional, processador, memoriaRam, qntDisco, placaRede)
VALUES ('Ubuntu', 'Linux', 'Intel Xeon E5', 16, 2, 'Intel Ethernet I210');


-- Tabela Servidor para armazenar dados dos servidores e associá-los à empresa e especificações
-- Tabela Servidor para armazenar dados dos servidores e associá-los à empresa e especificações
CREATE TABLE IF NOT EXISTS Servidor (
    idServidor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50),
    fkEmpresa INT,
    fkEspecificacao INT,
    UNIQUE (idServidor),  -- Garantir que idServidor seja único
    FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa),
    FOREIGN KEY (fkEspecificacao) REFERENCES Especificacoes(idEspecificacao)
);

-- Inserindo um registro na tabela Servidor, relacionando com Empresa e Especificacoes
INSERT INTO Servidor (nome, fkEmpresa, fkEspecificacao)
VALUES ('ServidorPrincipal', 1, 1);

-- Tabela Componentes para definir o tipo de componente e unidade de medida
CREATE TABLE IF NOT EXISTS Componentes (
    idComponente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL, -- Nome do componente (e.g., CPU Uso, Memória RAM)
    unidadeMedida VARCHAR(20) NOT NULL -- Unidade de medida (e.g., %, GB)
);


INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Bytes Enviados', 'MB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Bytes Recebidos', 'MB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Uso da CPU', '%');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Velocidade da CPU', 'MHz');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Tempo Ativo da CPU', 's');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Uso do Disco Total', 'GB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Uso do Disco Usado', 'GB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Uso do Disco Livre', 'GB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Porcentagem de Disco Usado', '%');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Tempo de Leitura do Disco', 'ms');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Tempo de Gravação do Disco', 'ms');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Memória Total', 'GB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Memória Disponível', 'GB');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Porcentagem de Memória Usada', '%');
INSERT INTO Componentes (nome, unidadeMedida) VALUES ('Memória Usada', 'GB');


select * from Componentes;

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
 