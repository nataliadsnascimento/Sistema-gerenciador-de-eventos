-- 1. Categoria do Evento
CREATE TABLE IF NOT EXISTS categoria_evento (
    id_categoria SERIAL PRIMARY KEY,
    nome_categoria VARCHAR(100),
    descricao VARCHAR(250),
    cor VARCHAR(20)
);

-- 2. Evento
CREATE TABLE IF NOT EXISTS evento (
    id_evento SERIAL PRIMARY KEY,
    titulo_evento VARCHAR(100),
    descricao TEXT,
    data_inicio TIMESTAMPTZ NOT NULL,
    data_fim TIMESTAMP NOT NULL,
    local VARCHAR(100),
    carga_horaria_evento INT NOT NULL,
    vagas_totais INT NOT NULL,
    status_evento VARCHAR(100),
    data_criacao INT NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria_evento(id_categoria) 
);

-- 3. Atividade 
CREATE TABLE IF NOT EXISTS atividade (
    id_atividade SERIAL PRIMARY KEY,
    nome_atividade VARCHAR(150) NOT NULL, 
    descricao TEXT,                       
    data DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL,
    local VARCHAR(100),
    capacidade INT NOT NULL,
    carga_horaria INT NOT NULL,
    id_evento INT NOT NULL,
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento) ON DELETE CASCADE
); 

-- 4. Palestra 
CREATE TABLE IF NOT EXISTS palestra (
    id_palestra SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    data_palestra DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fim TIME NOT NULL,
    carga_horaria INT NOT NULL,
    id_atividade INT NOT NULL,
    FOREIGN KEY (id_atividade) REFERENCES atividade(id_atividade) ON DELETE CASCADE
);

-- 5. Curso 
CREATE TABLE IF NOT EXISTS curso (
    id_curso SERIAL PRIMARY KEY,
    nome_curso VARCHAR(150) NOT NULL,
    descricao TEXT,
    id_atividade INT NOT NULL,
    FOREIGN KEY (id_atividade) REFERENCES atividade(id_atividade) ON DELETE CASCADE
);

-- 6. Arquivo
CREATE TABLE IF NOT EXISTS arquivo (
    id_arquivo SERIAL PRIMARY KEY,
    nome_arquivo VARCHAR(150) NOT NULL,
    tipo_arquivo VARCHAR(50) NOT NULL,
    data_upload DATE NOT NULL,
    id_palestra INT,
    id_curso INT,
    FOREIGN KEY (id_palestra) REFERENCES palestra(id_palestra) ON DELETE CASCADE,
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso) ON DELETE CASCADE
);

-- 7. Local 
CREATE TABLE IF NOT EXISTS local ( 
    id_local SERIAL PRIMARY KEY,
    id_palestra INT NOT NULL,
    id_curso INT NOT NULL,
    FOREIGN KEY (id_palestra) REFERENCES palestra(id_palestra),
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
);  

-- 8. Sala 
CREATE TABLE IF NOT EXISTS sala (
    id_sala SERIAL PRIMARY KEY,
    capacidade INT NOT NULL,
    recursos TEXT NOT NULL,
    id_local INT NOT NULL,
    FOREIGN KEY (id_local) REFERENCES local(id_local)
);

-- 9. Auditorio 
CREATE TABLE IF NOT EXISTS auditorio (
    id_auditorio SERIAL PRIMARY KEY,
    possui_palco BOOLEAN NOT NULL DEFAULT TRUE,
    quantidade_assento INT NOT NULL,
    acessibilidade TEXT NOT NULL,
    id_local INT NOT NULL,
    FOREIGN KEY (id_local) REFERENCES local(id_local)
);

-- 10. Laboratorio 
CREATE TABLE IF NOT EXISTS laboratorio (
    id_laboratorio SERIAL PRIMARY KEY,
    nome_laboratorio VARCHAR(100) NOT NULL,
    sistema_op VARCHAR (50),
    quantidade_computadores INT,
    id_local INT NOT NULL,
    id_curso INT,
    FOREIGN KEY (id_local) REFERENCES local(id_local) ON DELETE CASCADE,
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso) ON DELETE SET NULL
);

-- 11. Usuario 
CREATE TABLE IF NOT EXISTS usuario (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    tipo_usuario VARCHAR(20) NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 12. Usuario Telefone 
CREATE TABLE IF NOT EXISTS usuario_telefone (
    telefone VARCHAR(20),
    id_usuario INT,
    PRIMARY KEY (telefone, id_usuario),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

-- 13. Participante 
CREATE TABLE IF NOT EXISTS participante (
    id_usuario SERIAL PRIMARY KEY,
    matricula VARCHAR(50),
    instituicao VARCHAR(150),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

-- 14. Organizador 
CREATE TABLE IF NOT EXISTS organizador (
    id_usuario SERIAL PRIMARY KEY,
    departamento VARCHAR(100),
    cargo VARCHAR(100),
    curso VARCHAR(100),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

-- 15. Palestrante 
CREATE TABLE IF NOT EXISTS palestrante (
    id_usuario SERIAL PRIMARY KEY,
    curriculo_lattes VARCHAR(255),
    instituicao VARCHAR(150),
    biografia TEXT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

-- 16. Inscricao 
CREATE TABLE IF NOT EXISTS inscricao (
    id_inscricao SERIAL PRIMARY KEY,
    data_inscricao DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    id_usuario INT NOT NULL,
    id_atividade INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES participante(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_atividade) REFERENCES atividade(id_atividade) ON DELETE CASCADE
);

-- 17. Presenca 
CREATE TABLE IF NOT EXISTS presenca (
    id_presenca SERIAL PRIMARY KEY,
    data_registro DATE NOT NULL,
    status VARCHAR(50) NOT NULL,
    id_inscricao INT NOT NULL,
    id_atividade INT NOT NULL,
    FOREIGN KEY (id_inscricao) REFERENCES inscricao(id_inscricao) ON DELETE CASCADE,
    FOREIGN KEY (id_atividade) REFERENCES atividade(id_atividade) ON DELETE CASCADE
);

-- 18. Certificado 
CREATE TABLE IF NOT EXISTS certificado (
    id_certificado SERIAL PRIMARY KEY,
    data_emissao DATE NOT NULL,
    codigo_verificacao VARCHAR(100) UNIQUE NOT NULL,
    carga_horaria INT NOT NULL,
    arquivo_certificado VARCHAR(255),
    id_presenca INT NOT NULL,
    FOREIGN KEY (id_presenca) REFERENCES presenca(id_presenca) ON DELETE CASCADE
);

-- 19. Pagamento 
CREATE TABLE IF NOT EXISTS pagamento (
    id_pagamento SERIAL PRIMARY KEY,
    id_inscricao INT NOT NULL, 
    FOREIGN KEY (id_inscricao) REFERENCES inscricao(id_inscricao) ON DELETE CASCADE
);

-- 20. Gratuito 
CREATE TABLE IF NOT EXISTS gratuito (
    id_pagamento SERIAL PRIMARY KEY,
    cota_social BOOLEAN NOT NULL,
    motivo_isencao TEXT,
    comprovante_isencao VARCHAR(255),
    FOREIGN KEY (id_pagamento) REFERENCES pagamento(id_pagamento) ON DELETE CASCADE
);

-- 21. Pago 
CREATE TABLE IF NOT EXISTS pago (
    id_pagamento SERIAL PRIMARY KEY,
    valor DECIMAL(10, 2) NOT NULL,
    opcao_pagamento VARCHAR(50) NOT NULL,
    data_vencimento DATE NOT NULL,
    comprovante VARCHAR(255),
    FOREIGN KEY (id_pagamento) REFERENCES pagamento(id_pagamento) ON DELETE CASCADE
);

-- 22. Patrocinador
CREATE TABLE IF NOT EXISTS patrocinador (
    id_patrocinador SERIAL PRIMARY KEY,
    nome_patrocinador VARCHAR(100),
    cnpj VARCHAR(14)
);

-- 23. Evento Organizado 
CREATE TABLE IF NOT EXISTS evento_organizado (
    funcao VARCHAR(100),
    id_usuario INT NOT NULL,
    id_evento INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento)
);

-- 24. Evento Patrocinador
CREATE TABLE IF NOT EXISTS evento_patrocinador (
    tipo_cota VARCHAR(100),
    valor_cota INT,
    id_evento INT NOT NULL,
    id_patrocinador INT NOT NULL,
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento),
    FOREIGN KEY (id_patrocinador) REFERENCES patrocinador(id_patrocinador)
);