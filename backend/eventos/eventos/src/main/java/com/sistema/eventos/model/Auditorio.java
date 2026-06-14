package com.sistema.eventos.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Table(name = "auditorio")
@Data
@EqualsAndHashCode(callSuper = true)
public class Auditorio extends Local{
    @Column(name = "possui_palco", nullable = false)
    private Boolean possuiPalco;

    @Column(name = "quantidade_assento", nullable = false)
    private Integer quantidadeAssento;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String acessibilidade;
}
