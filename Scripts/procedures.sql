CREATE OR REPLACE PROCEDURE pr_registrar_participante_e_inscrever(
    p_nome VARCHAR, p_sobrenome VARCHAR, p_email VARCHAR, p_senha VARCHAR,
    p_matricula VARCHAR, p_instituicao VARCHAR, p_id_atividade INT
)
LANGUAGE plpgsql AS $$
DECLARE
    v_id_usuario INT;
BEGIN
    INSERT INTO usuario (nome, sobrenome, email, senha, tipo_usuario)
    VALUES (p_nome, p_sobrenome, p_email, p_senha, 'Participante')
    RETURNING id_usuario INTO v_id_usuario;

    INSERT INTO participante (id_usuario, matricula, instituicao)
    VALUES (v_id_usuario, p_matricula, p_instituicao);

    INSERT INTO inscricao (data_inscricao, status, id_usuario, id_atividade)
    VALUES (CURRENT_DATE, 'Confirmada', v_id_usuario, p_id_atividade);
    
    RAISE NOTICE 'Usuário % cadastrado e inscrito com sucesso!', p_nome;
END;
$$;