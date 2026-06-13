CREATE OR REPLACE FUNCTION fn_verificar_capacidade_atividade()
RETURNS TRIGGER AS $$
DECLARE
    v_capacidade INT;
    v_inscritos INT;
BEGIN
    SELECT capacidade INTO v_capacidade FROM atividade WHERE id_atividade = NEW.id_atividade;
    SELECT COUNT(*) INTO v_inscritos FROM inscricao WHERE id_atividade = NEW.id_atividade AND status = 'Confirmada';
    
    IF v_inscritos >= v_capacidade THEN
        RAISE EXCEPTION 'Não é possível realizar a inscrição. A atividade já atingiu a capacidade máxima.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_antes_inscrever_participante
BEFORE INSERT ON inscricao
FOR EACH ROW
EXECUTE FUNCTION fn_verificar_capacidade_atividade();


CREATE TRIGGER trg_validar_datas_evento
BEFORE INSERT OR UPDATE ON evento
FOR EACH ROW
EXECUTE FUNCTION fn_validar_datas_evento();