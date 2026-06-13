package com.sistema.eventos;

import org.springframework.boot.SpringApplication;

public class TestEventosApplication {

	public static void main(String[] args) {
		SpringApplication.from(EventosApplication::main).with(TestcontainersConfiguration.class).run(args);
	}

}
