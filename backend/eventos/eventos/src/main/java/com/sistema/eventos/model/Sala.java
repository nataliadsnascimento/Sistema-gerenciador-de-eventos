package com.sistema.eventos.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Table(name = "sala")
@Data
@EqualsAndHashCode(callSuper=true)
public class Sala extends Local {

    @Column(nullable = false)
    private Integer capacidade;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String recursos;
}
