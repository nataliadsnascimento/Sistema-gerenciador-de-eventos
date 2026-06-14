package com.sistema.eventos.dto;

import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class ConfirmacaPagamentoDTO {
    private Integer idInscricao;
    private Boolean ehPago;
    private BigDecimal valor;
    private String opcaoPagamento;
    private LocalDate dataVencimento;
    private String comprovante;
    private Boolean cotaSocial;
    private String motivoIsencao;
    private String comprovanteIsencao;
}
