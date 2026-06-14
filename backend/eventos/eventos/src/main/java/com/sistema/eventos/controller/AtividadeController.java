package com.sistema.eventos.controller;

import com.sistema.eventos.model.Atividade;
import com.sistema.eventos.repository.AtividadeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/atividades")
public class AtividadeController {

    @Autowired
    private AtividadeRepository atividadeRepository;

    @GetMapping
    public ResponseEntity<List<Atividade>> listarAtividades(){
        List<Atividade> atividades = atividadeRepository.findAll();
        return ResponseEntity.ok(atividades);
    }
}
