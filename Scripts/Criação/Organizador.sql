CREATE TABLE IF NOT EXISTS organizador (
    id_usuario INT PRIMARY KEY,
    departamento VARCHAR(100),
    cargo VARCHAR(100),
    curso VARCHAR(100),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);