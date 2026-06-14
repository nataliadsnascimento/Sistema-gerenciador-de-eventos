CREATE TABLE IF NOT EXISTS usuario (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    tipo_usuario VARCHAR(20) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS usuario_telefone (
    telefone VARCHAR(20),
    id_usuario INT,
    PRIMARY KEY (telefone, id_usuario),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS participante (
    id_usuario INT PRIMARY KEY, 
    matricula VARCHAR(50),
    instituicao VARCHAR(150),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS organizador (
    id_usuario INT PRIMARY KEY, 
    departamento VARCHAR(100),
    cargo VARCHAR(100),
    curso VARCHAR(100),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS palestrante (
    id_usuario INT PRIMARY KEY, 
    curriculo_lattes VARCHAR(255),
    instituicao VARCHAR(150),
    biografia TEXT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS categoria_evento(
    id_categoria SERIAL PRIMARY KEY,
    nome_categoria VARCHAR(100),
    descricao VARCHAR(250),
    cor VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS local( 
    id_local SERIAL PRIMARY KEY,
    nome_bloco VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS sala(
    id_local INT PRIMARY KEY, 
    capacidade INT NOT NULL,
    recursos TEXT NOT NULL,
    FOREIGN KEY (id_local) REFERENCES local(id_local) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS auditorio(
    id_local INT PRIMARY KEY, 
    possui_palco BOOL NOT NULL DEFAULT TRUE,
    quantidade_assento INT NOT NULL,
    acessibilidade TEXT NOT NULL,
    FOREIGN KEY (id_local) REFERENCES local(id_local) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS laboratorio (
    id_local INT PRIMARY KEY, 
    nome_laboratorio VARCHAR(100) NOT NULL,
    sistema_op VARCHAR (50),
    quantidade_computadores INT,
    FOREIGN KEY (id_local) REFERENCES local(id_local) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS evento(
    id_evento SERIAL PRIMARY KEY,
    titulo_evento VARCHAR(100),
    descricao TEXT,
    data_inicio TIMESTAMPTZ NOT NULL,
    data_fim TIMESTAMPTZ NOT NULL,
    carga_horaria_evento INT NOT NULL,
    vagas_totais INT NOT NULL,
    status_evento VARCHAR(100),
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_categoria INT NOT NULL,
    id_local INT,
    FOREIGN KEY (id_categoria) REFERENCES categoria_evento(id_categoria),
    FOREIGN KEY (id_local) REFERENCES local(id_local)
);

CREATE TABLE IF NOT EXISTS atividade (
    id_atividade SERIAL PRIMARY KEY,
    nome_atividade VARCHAR(150) NOT NULL, 
    descricao TEXT,                      
    data DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL,
    capacidade INT NOT NULL,
    carga_horaria INT NOT NULL,
    id_evento INT NOT NULL,
    id_local INT,
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento) ON DELETE CASCADE,
    FOREIGN KEY (id_local) REFERENCES local(id_local)
);  

CREATE TABLE IF NOT EXISTS inscricao (
    id_inscricao SERIAL PRIMARY KEY,
    data_inscricao DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    id_usuario INT NOT NULL,
    id_atividade INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_atividade) REFERENCES atividade(id_atividade) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS pagamento (
    id_pagamento SERIAL PRIMARY KEY,
    id_inscricao INT NOT NULL, 
    FOREIGN KEY (id_inscricao) REFERENCES inscricao(id_inscricao) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS gratuito (
    id_pagamento INT PRIMARY KEY, 
    cota_social BOOLEAN NOT NULL,
    motivo_isencao TEXT,
    comprovante_isencao VARCHAR(255),
    FOREIGN KEY (id_pagamento) REFERENCES pagamento(id_pagamento) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS pago (
    id_pagamento INT PRIMARY KEY, 
    valor DECIMAL(10, 2) NOT NULL,
    opcao_pagamento VARCHAR(50) NOT NULL,
    data_vencimento DATE NOT NULL,
    comprovante VARCHAR(255),
    FOREIGN KEY (id_pagamento) REFERENCES pagamento(id_pagamento) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS evento_organizado(
    funcao  VARCHAR(100),
    id_usuario INT NOT NULL,
    id_evento INT NOT NULL,
    PRIMARY KEY (id_usuario, id_evento),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento)
);

CREATE TABLE IF NOT EXISTS patrocinador(
    id_patrocinador SERIAL PRIMARY KEY,
    nome_patrocinador VARCHAR(100),
    cnpj VARCHAR(14)
);

CREATE TABLE IF NOT EXISTS evento_patrocinador(
    tipo_cota VARCHAR(100),
    valor_cota DECIMAL(10,2),
    id_evento INT NOT NULL,
    id_patrocinador INT NOT NULL,
    PRIMARY KEY (id_evento, id_patrocinador),
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento),
    FOREIGN KEY (id_patrocinador) REFERENCES patrocinador(id_patrocinador)
);

CREATE TABLE IF NOT EXISTS palestra (
    id_atividade INT PRIMARY KEY,
    FOREIGN KEY (id_atividade) REFERENCES atividade(id_atividade) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS curso (
    id_atividade INT PRIMARY KEY,
    FOREIGN KEY (id_atividade) REFERENCES atividade(id_atividade) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS presenca (
    id_presenca SERIAL PRIMARY KEY,
    data_registro DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    id_inscricao INT NOT NULL,
    FOREIGN KEY (id_inscricao) REFERENCES inscricao(id_inscricao) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS certificado (
    id_certificado SERIAL PRIMARY KEY,
    data_emissao DATE NOT NULL,
    codigo_verificacao VARCHAR(100) UNIQUE NOT NULL,
    carga_horaria INT NOT NULL,
    arquivo_certificado VARCHAR(255),
    id_presenca INT NOT NULL,
    FOREIGN KEY (id_presenca) REFERENCES presenca(id_presenca) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS arquivo (
    id_arquivo SERIAL PRIMARY KEY,
    nome_arquivo VARCHAR(150) NOT NULL,
    tipo_arquivo VARCHAR(50) NOT NULL,
    data_upload DATE NOT NULL,
    id_palestra INT,
    id_curso INT,
    FOREIGN KEY (id_palestra) REFERENCES palestra(id_atividade) ON DELETE CASCADE,
    FOREIGN KEY (id_curso) REFERENCES curso(id_atividade) ON DELETE CASCADE
);