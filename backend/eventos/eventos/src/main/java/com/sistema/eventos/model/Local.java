package com.sistema.eventos.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "local")
@Inheritance(strategy = InheritanceType.JOINED)
@Data
public class Local {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer idLocal;

    @Column(name = "nome_bloco", nullable = false, length = 100)
    private String nomeBloclo;
}

