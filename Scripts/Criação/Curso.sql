CREATE TABLE IF NOT EXISTS curso (
	id_curso SERIAL PRIMARY KEY,
	nome_curso VARCHAR(150) NOT NULL,
	descricao TEXT,
	id_atividade INT NOT NULL,
	FOREIGN KEY (id_atividade) REFERENCES atividade(id_atividade) ON DELETE CASCADE
);