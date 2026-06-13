CREATE OR REPLACE VIEW vw_ocupacao_atividades AS
SELECT 
    a.id_atividade,
    a.nome_atividade,
    a.capacidade AS vagas_totais,
    COUNT(i.id_inscricao) AS vagas_ocupadas,
    (a.capacidade - COUNT(i.id_inscricao)) AS vagas_restantes
FROM atividade a
LEFT JOIN inscricao i ON i.id_atividade = a.id_atividade AND i.status = 'Confirmada'
GROUP BY a.id_atividade, a.nome_atividade, a.capacidade;


CREATE OR REPLACE VIEW view_cronograma_atividades AS
SELECT
	e.titulo_evento AS evento,
	c_ev.nome_categoria AS categoria_evento,
	a.id_atividade,
	a.nome_atividade AS atividade,
	a.descricao AS descricao_atividade,
	a.data AS data_atividade,
	a.hora_inicio,
	a.hora_fim,
	a.local AS local_atividade,
	a.carga_horaria,
	a.capacidade,
	CASE
		WHEN p.id_palestra IS NOT NULL THEN 'Palestra'
		WHEN c.id_curso IS NOT NULL THEN 'Curso'
		ELSE 'Outro/Geral'
	END AS tipo_atividade,
	COALESCE(p.titulo, c.nome_curso) AS detalhe_subtipo
FROM atividade a
JOIN evento e ON a.id_evento = e.id_evento
JOIN categoria_evento c_ev ON e.id_categoria = c_ev.id_categoria
LEFT JOIN palestra p ON a.id_atividade = p.id_atividade
LEFT JOIN curso c ON a.id_atividade = c.id_atividade
ORDER BY a.data ASC, a.hora_inicio ASC;


create or replace view arrecadacao_evento as 
select
	evento.id_evento,
	evento.titulo_evento as evento,
	count(pago.id_pagamento) as qtd_incricoes_pagas,
	coalesce(sum(pago.valor), 0.00) as total_arrecadado	
from evento  
join atividade ativ on ativ.id_evento = evento.id_evento
join inscricao ins on ins.id_atividade = ativ.id_atividade
join pagamento pag on pag.id_inscricao = ins.id_inscricao 
join pago on pago.id_pagamento = pag.id_pagamento
where ins.status = 'Confirmada'
group by evento.id_evento, evento.titulo_evento
order by total_arrecadado desc;

create or replace view perfil_de_usuario as 
select
	usuario.id_usuario,
	usuario.nome || ' ' || usuario.sobrenome as nome_completo,
	usuario.email,
	usuario.tipo_usuario as papel_principal,
	case when organizador.id_usuario is not null then 'Sim' else 'Não' end as eh_organizador,
	case when participante.id_usuario is not null then 'Sim' else 'Não' end as eh_participante,
	case when palestrante.id_usuario is not null then 'Sim' else 'Não' end as eh_palestrante
from usuario 
left join organizador on usuario.id_usuario = organizador.id_usuario
left join participante on usuario.id_usuario = participante.id_usuario
left join palestrante on usuario.id_usuario = palestrante.id_usuario
