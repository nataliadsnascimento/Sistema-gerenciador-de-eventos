package com.sistema.eventos.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Table(name = "curso")
@Data
@EqualsAndHashCode(callSuper = true)
public class Curso extends Atividade {
}