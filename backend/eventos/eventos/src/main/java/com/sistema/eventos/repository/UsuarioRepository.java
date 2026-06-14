package com.sistema.eventos.repository;

import com.sistema.eventos.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
    @Modifying
    @Transactional
    @Query(value = "CALL cadastrar_palestrante(:nome, :sobrenome, :email, :senha, :lattes, :instituicao, :biografia)", nativeQuery = true)
    void cadastrarPalestrante(
            @Param("nome") String nome,
            @Param("sobrenome") String sobrenome,
            @Param("email") String email,
            @Param("senha") String senha,
            @Param("lattes") String lattes,
            @Param("instituicao") String instituicao,
            @Param("biografia") String biografia
    );
}
