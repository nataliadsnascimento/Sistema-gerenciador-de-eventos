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