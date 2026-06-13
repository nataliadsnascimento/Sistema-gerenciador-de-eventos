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


CREATE OR REPLACE PROCEDURE pr_confirmar_pagamento(
    p_id_inscricao INT,
    p_eh_pago BOOLEAN,
    p_valor DECIMAL(10,2) DEFAULT NULL,
    p_opcao_pagamento VARCHAR(50) DEFAULT NULL,
    p_data_vencimento DATE DEFAULT NULL,
    p_comprovante VARCHAR(255) DEFAULT NULL,
    p_cota_social BOOLEAN DEFAULT FALSE,
    p_motivo_isencao TEXT DEFAULT NULL,
    p_comprovante_isencao VARCHAR(255) DEFAULT NULL
)
LANGUAGE plpgsql AS $$
DECLARE
    v_id_pagamento INT;
    v_status_atual VARCHAR(50);
BEGIN
    
    SELECT status INTO v_status_atual FROM inscricao WHERE id_inscricao = p_id_inscricao;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Inscrição com ID % não encontrada.', p_id_inscricao;
    END IF;
    
    IF v_status_atual = 'Confirmada' THEN
        RAISE NOTICE 'A inscrição % já está confirmada.', p_id_inscricao;
        RETURN;
    END IF;

    
    INSERT INTO pagamento (id_inscricao) 
    VALUES (p_id_inscricao)
    RETURNING id_pagamento INTO v_id_pagamento;

   
    IF p_eh_pago THEN
        IF p_valor IS NULL OR p_opcao_pagamento IS NULL THEN
            RAISE EXCEPTION 'Para pagamentos pagos, o valor e a opção de pagamento são obrigatórios.';
        END IF;

        INSERT INTO pago (id_pagamento, valor, opcao_pagamento, data_vencimento, comprovante)
        VALUES (v_id_pagamento, p_valor, p_opcao_pagamento, COALESCE(p_data_vencimento, CURRENT_DATE), p_comprovante);
    ELSE
        INSERT INTO gratuito (id_pagamento, cota_social, motivo_isencao, comprovante_isencao)
        VALUES (v_id_pagamento, p_cota_social, p_motivo_isencao, p_comprovante_isencao);
    END IF;

    
    UPDATE inscricao 
    SET status = 'Confirmada' 
    WHERE id_inscricao = p_id_inscricao;

    RAISE NOTICE 'Pagamento ID % registrado e Inscrição % confirmada com sucesso!', v_id_pagamento, p_id_inscricao;
END;
$$;