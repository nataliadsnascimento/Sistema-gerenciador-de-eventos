package com.sistema.eventos.controller;

import com.sistema.eventos.dto.ConfirmacaPagamentoDTO;
import com.sistema.eventos.dto.RegistroInscricaoDTO;
import com.sistema.eventos.repository.InscricaoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/inscricoes")
public class InscricaoController {

    @Autowired
    private InscricaoRepository inscricaoRepository;

    @PostMapping("/registrar")
    public ResponseEntity<String> registrarParticipante(@RequestBody RegistroInscricaoDTO dto) {
        try {
            inscricaoRepository.registrarParticipanteEInscrever(
                    dto.getNome(),
                    dto.getSobrenome(),
                    dto.getEmail(),
                    dto.getSenha(),
                    dto.getMatricula(),
                    dto.getInstituicao(),
                    dto.getIdAtividade()
            );
            return ResponseEntity.ok("Participante registado e inscrição pendente criada com sucesso!");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Erro ao realizar inscrição: " + e.getMessage());
        }
    }

    @PutMapping("/pagamento")
    public ResponseEntity<String> confirmarPagamento(ConfirmacaPagamentoDTO dto) {
        try {
            inscricaoRepository.confirmarPagamento(
                    dto.getIdInscricao(),
                    dto.getEhPago(),
                    dto.getValor(),
                    dto.getOpcaoPagamento(),
                    dto.getDataVencimento(),
                    dto.getComprovante(),
                    dto.getCotaSocial(),
                    dto.getMotivoIsencao(),
                    dto.getComprovanteIsencao()
            );
            return ResponseEntity.ok("Pagamento processado e status da inscrição atualizado!");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Erro ao processar pagamento: " + e.getMessage());
        }
    }

    @DeleteMapping("/cancelar/{id}")
    public ResponseEntity<String> cancelarInscricao(@PathVariable("id") Integer id) {
        try {
            inscricaoRepository.cancelarInscricao(id);
            return ResponseEntity.ok("Inscrição cancelada com sucesso. Vaga liberada!");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Erro ao cancelar inscrição: " + e.getMessage());
        }
    }
}