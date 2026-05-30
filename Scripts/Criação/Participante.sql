CREATE TABLE IF NOT EXISTS participante (
    id_usuario INT PRIMARY KEY,
    matricula VARCHAR(50),
    instituicao VARCHAR(150),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);