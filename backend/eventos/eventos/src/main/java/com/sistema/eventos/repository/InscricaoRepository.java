package com.sistema.eventos.repository;

import com.sistema.eventos.model.Inscricao;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.time.LocalDate;

@Repository
public interface InscricaoRepository extends JpaRepository<Inscricao, Integer> {
    @Modifying
    @Transactional
    @Query(value = "CALL pr_registrar_participante_e_inscrever(:nome, :sobrenome, :email, :senha, :matricula, :instituicao, :idAtividade)", nativeQuery = true)
    void registrarParticipanteEInscrever(
            @Param("nome") String nome,
            @Param("sobrenome") String sobrenome,
            @Param("email") String email,
            @Param("senha") String senha,
            @Param("matricula") String matricula,
            @Param("instituicao") String instituicao,
            @Param("idAtividade") Integer idAtividade
    );

    @Modifying
    @Transactional
    @Query(value = "CALL pr_confirmar_pagamento(:idInscricao, :ehPago, :valor, :opcaoPagamento, :dataVencimento, :comprovante, :cotaSocial, :motivoIsencao, :comprovanteIsencao)", nativeQuery = true)
    void confirmarPagamento(
            @Param("idInscricao") Integer idInscricao,
            @Param("ehPago") Boolean ehPago,
            @Param("valor") BigDecimal valor,
            @Param("opcaoPagamento") String opcaoPagamento,
            @Param("dataVencimento") LocalDate dataVencimento,
            @Param("comprovante") String comprovante,
            @Param("cotaSocial") Boolean cotaSocial,
            @Param("motivoIsencao") String motivoIsencao,
            @Param("comprovanteIsencao") String comprovanteIsencao
    );

    @Modifying
    @Transactional
    @Query(value = "CALL cancelar_inscricao(:idInscricao)", nativeQuery = true)
    void cancelarInscricao(
            @Param("idInscricao") Integer idInscricao
    );

    @Modifying
    @Transactional
    @Query(value = "CALL encerrar_inscricoes_evento(:idEvento)", nativeQuery = true)
    void encerrarInscricoesEvento(
            @Param("idEvento") Integer idEvento
    );

}