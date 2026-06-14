package com.sistema.eventos.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Table(name = "organizador")
@Data
@EqualsAndHashCode(callSuper = false)
public class Organizador extends Usuario {
    @Column(length = 100)
    private String departamento;

    @Column(length = 100)
    private String cargo;

    @Column(length = 100)
    private String curso;
}
