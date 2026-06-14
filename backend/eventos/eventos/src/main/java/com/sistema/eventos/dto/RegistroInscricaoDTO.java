package com.sistema.eventos.dto;

import lombok.Data;

@Data
public class RegistroInscricaoDTO {
    private String nome;
    private String sobrenome;
    private String email;
    private String senha;
    private String matricula;
    private String instituicao;
    private Integer idAtividade;
}
