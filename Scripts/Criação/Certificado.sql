CREATE TABLE IF NOT EXISTS certificado (
	id_certificado SERIAL PRIMARY KEY,
	data_emissao DATE NOT NULL,
	codigo_verificacao VARCHAR(100) UNIQUE NOT NULL,
	carga_horaria INT NOT NULL,
	arquivo_certificado VARCHAR(255),
	id_presenca INT NOT NULL,
	FOREIGN KEY (id_presenca) REFERENCES presenca(id_presenca) ON DELETE CASCADE
);