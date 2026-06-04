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