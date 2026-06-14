package com.sistema.eventos.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Entity
@Table(name = "palestra")
@Data
@EqualsAndHashCode(callSuper = true)
public class Palestra extends Atividade {
}