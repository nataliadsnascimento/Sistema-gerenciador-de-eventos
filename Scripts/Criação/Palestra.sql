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