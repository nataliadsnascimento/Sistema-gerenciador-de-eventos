CREATE TABLE IF NOT EXISTS inscricao (
	id_inscricao SERIAL PRIMARY KEY,
	data_inscricao DATE NOT NULL,
	status VARCHAR(50) NOT NULL,
	id_usuario INT NOT NULL,
	id_atividade INT NOT NULL,
	FOREIGN KEY (id_usuario) REFERENCES participante(id_usuario) ON DELETE CASCADE,
	FOREIGN KEY (id_atividade) REFERENCES atividade(id_atividade) ON DELETE CASCADE
);