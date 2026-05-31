create table if not exists categoria_evento(
	id_categoria serial primary key,
	nome_categoria varchar(100),
	descricao varchar(250),
	cor varchar(20)
);
