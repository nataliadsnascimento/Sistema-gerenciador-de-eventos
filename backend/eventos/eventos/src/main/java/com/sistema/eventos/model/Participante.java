package com.sistema.eventos.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Table(name = "participante")
@Data
@EqualsAndHashCode(callSuper = true)
public class Participante extends Usuario {
    @Column(length = 50)
    private String matricula;

    @Column(length = 50)
    private String instituicao;
}
