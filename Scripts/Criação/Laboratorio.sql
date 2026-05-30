CREATE TABLE IF NOT EXISTS laboratorio (
	id_laboratorio SERIAL PRIMARY KEY,
	nome_laboratorio VARCHAR(100) NOT NULL,
	sistema_op VARCHAR (50),
	quantidade_computadores INT,
	id_local INT NOT NULL,
	id_curso INT,
	FOREIGN KEY (id_local) REFERENCES local(id_local) ON DELETE CASCADE,
	FOREIGN KEY (id_curso) REFERENCES curso(id_curso) ON DELETE SET NULL
);