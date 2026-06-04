CREATE TABLE IF NOT EXISTS palestrante (
    id_usuario SERIAL PRIMARY KEY,
    curriculo_lattes VARCHAR(255),
    instituicao VARCHAR(150),
    biografia TEXT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);