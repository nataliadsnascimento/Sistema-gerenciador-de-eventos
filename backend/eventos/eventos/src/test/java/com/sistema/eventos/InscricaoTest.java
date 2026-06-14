package com.sistema.eventos;


import com.sistema.eventos.dto.RegistroInscricaoDTO;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import tools.jackson.databind.ObjectMapper;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
public class InscricaoTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @Test
    public void testarRegistroDeParticipante() throws Exception {
        RegistroInscricaoDTO dto = new RegistroInscricaoDTO();
        dto.setNome("Aluno");
        dto.setSobrenome("Teste");
        dto.setEmail("aluno.teste@upe.br");
        dto.setSenha("123456");
        dto.setIdAtividade(1);

        mockMvc.perform(post("/api/inscricoes/registrar")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(dto)))
                .andExpect(status().isOk());
    }
}