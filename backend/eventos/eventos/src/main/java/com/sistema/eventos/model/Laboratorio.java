package com.sistema.eventos.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Table(name = "laboratorio")
@Data
@EqualsAndHashCode(callSuper = true)
public class Laboratorio extends Local {

    @Column(name = "nome_laboratorio", nullable = false, length = 100)
    private String nomeLaboratorio;

    @Column(name = "sistema_op", length = 50)
    private String sistemaOp;

    @Column(name = "quantidade_computadores")
    private Integer quantidadeComputadores;
}