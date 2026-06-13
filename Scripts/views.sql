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
	