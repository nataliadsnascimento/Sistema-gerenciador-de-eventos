create table if not exists evento(
	id_evento serial primary key,
	titulo_evento varchar(100),
	descricao text,
	data_inicio timestamptz not null,
	data_fim timestamp not null,
	local varchar(100),
	carga_horaria_evento int not null,
	vagas_totais int not null,
	status_evento varchar(100),
	data_criacao int not null,
	id_categoria int not null,
	foreign key (id_categoria) references categoria_evento(id_categoria) 
);