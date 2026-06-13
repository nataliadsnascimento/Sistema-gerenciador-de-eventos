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

create or replace procedure cadastrar_palestrante(
	palestrante_nome varchar(50),
	palestrante_sobrenome varchar(50),
	palestrante_email varchar(100),
	palestrante_senha varchar(255),
	palestrante_curriculo_lattes varchar(255),
	palestrante_instituicao varchar(100),
	palestrante_biografia text
)
language plpgsql as $$
declare
	v_id_usuario int;
begin
	insert into usuario (nome, sobrenome, email, senha, tipo_usuario)
	values (palestrante_nome, palestrante_sobrenome, palestrante_email, palestrante_senha, 'Palestrante')
	returning id_usuario into v_id_usuario;

	insert into palestrante (id_usuario, curriculo_lattes, instituicao, biografia)
	values (v_id_usuario, palestrante_curriculo_lattes, palestrante_instituicao, palestrante_biografia);
	
	raise notice 'Palestrante % % cadastrado com sucesso! (ID: %)', palestrante_nome, palestrante_sobrenome,v_id_usuario;
exception
	when unique_violation then
		raise exception 'Erro, o email % já está cadastrado no sistema', palestrante_email;
	when others then
		raise exception 'Erro inesperado ao cadastrar palestrante: %', sqlerrm;
end;
$$;

create or replace procedure cancelar_inscricao(
	p_id_inscricao int
)
language plpgsql as $$ 
declare 
	status_atual varchar(50);
begin
	select status into status_atual from inscricao where id_inscricao = p_id_inscricao;
	
	if not found then 
		raise exception 'Inscrição com ID % não encontrada', p_id_inscricao;
	end if;
	
	if status_atual = 'Cancelada' then
		raise notice 'A inscriçao % já se encontra cancelada', p_id_inscricao;
	return;
	end if;
	
	update inscricao
	set status = 'Cancelada'
	where id_inscricao 	= p_id_inscricao;
	
	update pago 
	set comprovante = 'Cancelado_pelo_usuario' || to_char(current_date, 'YYYYMMDD')
	where id_pagamento in (select id_pagamento from pagamento where id_inscricao = cancelar_inscricao.p_id_inscricao);
	
	raise notice 'Inscrição % cancelada com sucesso. A vaga está liberada', p_id_inscricao;
end;
$$;