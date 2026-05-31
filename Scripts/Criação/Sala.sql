create table if not exists sala(
	id_sala serial primary key,
	capacidade int not null,
	recursos text not null,
	id_local int not null,
	foreign key (id_local) references local(id_local)
);