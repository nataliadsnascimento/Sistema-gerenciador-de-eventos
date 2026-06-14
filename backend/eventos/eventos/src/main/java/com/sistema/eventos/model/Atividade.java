package com.sistema.eventos.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Table(name = "atividade")
@Inheritance(strategy = InheritanceType.JOINED)
@Data
public class Atividade {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_atividade")
    private Integer idAtividade;

    @Column(name = "nome_atividade", nullable = false, length = 150)
    private String nomeAtividade;

    @Column(columnDefinition = "TEXT")
    private String descricao;

    @Column(nullable = false)
    private LocalDate data;

    @Column(name = "hora_inicio", nullable = false)
    private LocalTime horaInicio;

    @Column(name = "hora_fim", nullable = false)
    private LocalTime horaFim;

    @Column(nullable = false)
    private Integer capacidade;

    @Column(name = "carga_horaria", nullable = false)
    private Integer cargaHoraria;

    @ManyToOne
    @JoinColumn(name = "id_local")
    private Local local;

    @Column(name = "id_evento", nullable = false)
    private Integer idEvento;
}
