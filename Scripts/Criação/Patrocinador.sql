create table if not exists patrocinador(
	id_patrocinador serial primary key,
	nome_patrocinador varchar(100),
	cnpj varchar(14)
);