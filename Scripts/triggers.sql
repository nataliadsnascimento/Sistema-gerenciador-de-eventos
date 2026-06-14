CREATE OR REPLACE FUNCTION fn_verificar_capacidade_atividade()
RETURNS TRIGGER AS $$
DECLARE
    v_capacidade INT;
    v_inscritos INT;
BEGIN
	IF NEW.status = 'Confirmada' THEN
    	SELECT capacidade INTO v_capacidade FROM atividade WHERE id_atividade = NEW.id_atividade;
    	SELECT COUNT(*) INTO v_inscritos FROM inscricao WHERE id_atividade = NEW.id_atividade AND status = 'Confirmada';
    
    IF v_inscritos >= v_capacidade THEN
        RAISE EXCEPTION 'Não é possível realizar a inscrição. A atividade já atingiu a capacidade máxima.';
    END IF;
END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_antes_inscrever_participante
BEFORE INSERT OR UPDATE OF status ON inscricao
FOR EACH ROW
EXECUTE FUNCTION fn_verificar_capacidade_atividade();


create or replace function evitar_choque_horario()
returns trigger as $$
declare 
	v_nova_data date;
	v_nova_hora_inicio time;
	v_nova_hora_fim time;
	v_conflitos int;
begin
	select data, hora_inicio, hora_fim
	into v_nova_data, v_nova_hora_inicio, v_nova_hora_fim
	from atividade
	where id_atividade = new.id_atividade;

	select count(*) into v_conflitos
	from inscricao i
	join atividade a on i.id_atividade = a.id_atividade
	where i.id_usuario = new.id_usuario
		and i.status = 'Confirmada'
		and i.id_inscricao <> coalesce(new.id_inscricao, 0)
		and a.data = v_nova_data
		and(
		(v_nova_hora_inicio >= a.hora_inicio and v_nova_hora_inicio < a.hora_fim) or
		(v_nova_hora_fim > a.hora_inicio and v_nova_hora_fim <= a.hora_fim) or
		(a.hora_inicio >= v_nova_hora_inicio and a.hora_inicio < v_nova_hora_fim)
		);
	if v_conflitos > 0 then
		raise exception 'Não é possível se inscrever. Você já possui uma atividade agendada para esse mesmo horário.';
	end if;
	return new;
end;
$$ language plpgsql;

create trigger tg_antes_inscricao_horario
before insert or update of status on inscricao
for each row
when (new.status = 'Confirmada')
execute function evitar_choque_horario();