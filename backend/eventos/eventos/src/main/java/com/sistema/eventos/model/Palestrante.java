package com.sistema.eventos.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Table(name = "palestrante")
@Data
@EqualsAndHashCode(callSuper = true)
public class Palestrante extends Usuario {

    @Column(name = "curriculo_lattes", length = 255)
    private String curriculoLattes;

    @Column(length = 150)
    private String instituicao;

    @Column(columnDefinition = "TEXT")
    private String biografia;
}