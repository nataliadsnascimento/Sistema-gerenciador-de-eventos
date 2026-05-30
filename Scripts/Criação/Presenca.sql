CREATE TABLE IF NOT EXISTS presenca (
	id_presenca SERIAL PRIMARY KEY,
	data_registro DATE NOT NULL,
	status VARCHAR(50) NOT NULL,
	id_inscricao INT NOT NULL,
	id_atividade INT NOT NULL,
	FOREIGN KEY (id_inscricao) REFERENCES inscricao(id_inscricao) ON DELETE CASCADE,
	FOREIGN KEY (id_atividade) REFERENCES atividade(id_atividade) ON DELETE CASCADE
);