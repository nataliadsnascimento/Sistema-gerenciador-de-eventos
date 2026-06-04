create table if not exists auditorio(
	id_auditorio serial primary key,
	possui_palco Bool not null default true,
	quantidade_assento int not null,
	acessibilidade text not null,
	id_local int not null,
	foreign key (id_local) references local(id_local)
);