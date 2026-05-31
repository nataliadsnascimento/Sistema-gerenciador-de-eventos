create table if not exists evento_organizado(
	funcao	varchar(100),
	id_usuario int not null,
	id_evento int not null,
	foreign key (id_usuario) references usuario(id_usuario),
	foreign key (id_evento) references evento(id_evento)
);
