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