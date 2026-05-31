create table if not exists local( 
	id_local serial primary key,
	id_palestra int not null,
	id_curso int not null,
	foreign key (id_palestra) references palestra(id_palestra),
	foreign key (id_curso) references curso(id_curso)
); 