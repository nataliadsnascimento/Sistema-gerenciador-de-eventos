SELECT
 	evento,
 	tipo_atividade,
 	atividade,
 	data_atividade,
 	hora_inicio,
 	local_atividade
FROM view_cronograma_atividades
WHERE data_atividade >= '2026-01-01'
ORDER BY data_atividade, hora_inicio;


SELECT 
    a.nome_atividade,
    a.capacidade AS capacidade_maxima,
    COUNT(i.id_inscricao) AS inscritos_confirmados,
    (a.capacidade - COUNT(i.id_inscricao)) AS vagas_restantes
FROM atividade a
LEFT JOIN inscricao i ON a.id_atividade = i.id_atividade AND i.status = 'Confirmada'
GROUP BY a.id_atividade, a.nome_atividade, a.capacidade
ORDER BY inscritos_confirmados DESC;


SELECT  
    e.titulo_evento AS evento,
    COUNT(DISTINCT p.id_pagamento) AS quantidade_vendas,
    SUM(DISTINCT pg.valor) AS faturamento_total
FROM evento e
JOIN atividade a ON e.id_evento = a.id_evento
JOIN inscricao i ON a.id_atividade = i.id_atividade
JOIN pagamento p ON i.id_inscricao = p.id_inscricao
JOIN pago pg ON p.id_pagamento = pg.id_pagamento
GROUP BY e.id_evento, e.titulo_evento
ORDER BY faturamento_total DESC;


SELECT 
    u.nome || ' ' || u.sobrenome AS participante,
    a.nome_atividade AS atividade,
    g.motivo_isencao,
    g.comprovante_isencao,
    g.cota_social
FROM gratuito g
JOIN pagamento p ON g.id_pagamento = p.id_pagamento
JOIN inscricao i ON p.id_inscricao = i.id_inscricao
JOIN usuario u ON i.id_usuario = u.id_usuario
JOIN atividade a ON i.id_atividade = a.id_atividade;


SELECT  
    p.nome_patrocinador,
    p.cnpj,
    COUNT(ep.id_evento) AS qtd_eventos_patrocinados,
    SUM(ep.valor_cota) AS total_investido
FROM patrocinador p
JOIN evento_patrocinador ep ON p.id_patrocinador = ep.id_patrocinador
GROUP BY p.id_patrocinador, p.nome_patrocinador, p.cnpj
ORDER BY total_investido DESC;


SELECT 
    u.nome || ' ' || u.sobrenome AS aluno,
    a.nome_atividade AS atividade,
    c.codigo_verificacao,
    c.carga_horaria AS horas_ganhas
FROM certificado c
JOIN presenca p ON c.id_presenca = p.id_presenca
JOIN inscricao i ON p.id_inscricao = i.id_inscricao
JOIN usuario u ON i.id_usuario = u.id_usuario
JOIN atividade a ON i.id_atividade = a.id_atividade
WHERE p.status = 'Presente';

SELECT 
    a.nome_atividade AS atividade,
    COUNT(p.id_presenca) AS total_inscritos,
    COUNT(CASE WHEN p.status = 'Presente' THEN 1 END) AS presentes,
    COUNT(CASE WHEN p.status = 'Ausente' THEN 1 END) AS faltas,
    ROUND((COUNT(CASE WHEN p.status = 'Presente' THEN 1 END) * 100.0) / COUNT(p.id_presenca), 2) || '%' AS taxa_comparecimento
FROM atividade a
JOIN inscricao i ON a.id_atividade = i.id_atividade
JOIN presenca p ON i.id_inscricao = p.id_inscricao
GROUP BY a.id_atividade, a.nome_atividade
ORDER BY total_inscritos DESC;

