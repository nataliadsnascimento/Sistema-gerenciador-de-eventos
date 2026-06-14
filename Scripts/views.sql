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
    l.nome_bloco AS local_atividade, 
    a.carga_horaria,
    a.capacidade,
    CASE
        WHEN p.id_atividade IS NOT NULL THEN 'Palestra' 
        WHEN c.id_atividade IS NOT NULL THEN 'Curso'    
        ELSE 'Outro/Geral'
    END AS tipo_atividade,
    CASE 
        WHEN c.id_atividade IS NOT NULL THEN 'Curso de Extensão/Capacitação'
        ELSE 'Palestra/Apresentação'
    END AS detalhe_subtipo 
FROM atividade a
JOIN evento e ON a.id_evento = e.id_evento
JOIN categoria_evento c_ev ON e.id_categoria = c_ev.id_categoria
LEFT JOIN local l ON a.id_local = l.id_local 
LEFT JOIN palestra p ON a.id_atividade = p.id_atividade
LEFT JOIN curso c ON a.id_atividade = c.id_atividade;


CREATE OR REPLACE VIEW arrecadacao_evento AS 
SELECT
    e.id_evento,
    e.titulo_evento AS evento,
    COUNT(pago.id_pagamento) AS qtd_inscricoes_pagas,
    COALESCE(SUM(pago.valor), 0.00) AS total_arrecadado 
FROM evento e
JOIN atividade ativ ON ativ.id_evento = e.id_evento
JOIN inscricao ins ON ins.id_atividade = ativ.id_atividade
JOIN pagamento pag ON pag.id_inscricao = ins.id_inscricao 
JOIN pago ON pago.id_pagamento = pag.id_pagamento
WHERE ins.status = 'Confirmada'
GROUP BY e.id_evento, e.titulo_evento;


CREATE OR REPLACE VIEW perfil_de_usuario AS 
SELECT
    usuario.id_usuario,
    usuario.nome || ' ' || usuario.sobrenome AS nome_completo,
    usuario.email,
    usuario.tipo_usuario AS papel_principal,
    CASE WHEN organizador.id_usuario IS NOT NULL THEN 'Sim' ELSE 'Não' END AS eh_organizador,
    CASE WHEN participante.id_usuario IS NOT NULL THEN 'Sim' ELSE 'Não' END AS eh_participante,
    CASE WHEN palestrante.id_usuario IS NOT NULL THEN 'Sim' ELSE 'Não' END AS eh_palestrante
FROM usuario 
LEFT JOIN organizador ON usuario.id_usuario = organizador.id_usuario
LEFT JOIN participante ON usuario.id_usuario = participante.id_usuario
LEFT JOIN palestrante ON usuario.id_usuario = palestrante.id_usuario;



CREATE OR REPLACE VIEW engajamento_usuarios AS
SELECT
    usuario.id_usuario,
    usuario.nome || ' ' || usuario.sobrenome AS nome_completo,
    usuario.email,
    COUNT(DISTINCT inscricao.id_inscricao) AS total_inscricoes,
    COUNT(DISTINCT CASE WHEN presenca.status = 'Presente' THEN presenca.id_presenca END) AS total_presenca,
    COUNT(DISTINCT certificado.id_certificado) AS certificados_emitidos
FROM usuario
LEFT JOIN inscricao ON usuario.id_usuario = inscricao.id_usuario
LEFT JOIN presenca ON inscricao.id_inscricao = presenca.id_inscricao
LEFT JOIN certificado ON presenca.id_presenca = certificado.id_presenca
GROUP BY usuario.id_usuario, usuario.nome, usuario.sobrenome, usuario.email;