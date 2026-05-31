create table if not exists evento_patrocinador(
	tipo_cota varchar(100),
	valor_cota int,
	id_evento int not null,
	id_patrocinador int not null,
	foreign key (id_evento) references evento(id_evento),
	foreign key (id_patrocinador) references patrocinador(id_patrocinador)
);