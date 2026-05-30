CREATE TABLE IF NOT EXISTS usuario_telefone (
    telefone VARCHAR(20),
    id_usuario INT,
    PRIMARY KEY (telefone, id_usuario),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);