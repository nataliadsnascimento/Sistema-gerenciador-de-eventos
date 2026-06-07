-- 1. Categoria Evento
INSERT INTO categoria_evento (nome_categoria, descricao, cor) VALUES
('Tecnologia e Inovação', 'Conferencia sobre o desenvolvimento de software, Ia e Infraestrutura', '#002244'),
('Ciencia e Academia', 'Semanas universitarias, simpósios de pesquisa e extensão', '#008080'),
('Negocios e Empreendedorismo', 'Workshops de gestão, startups e networking profissional', '#FF5733'),
('Artes e Cultura', 'Exposição, mostras culturais e eventos de design dentro da instituição', '#8E44AD'),
('Saúde e Bem-Estar', 'Palestras sobre a saúde mental na universidade e ergonomia', '#2ECC71');

-- 2. Evento
INSERT INTO evento (titulo_evento, descricao, data_inicio, data_fim, local, carga_horaria_evento, vagas_totais, status_evento, data_criacao, id_categoria) VALUES
('TechWeek 2026', 'Grande semana tecnológica com foco em Inteligência Artificial e Desenvolvimento Web', '2026-05-18 08:00:00-03', '2026-05-22 18:00:00-03', 'Bloco A - Campus Central', 40, 500, 'Inscrições Abertas', 2026, 1),
('Simpósio de Pesquisa e Extenssão', 'Apresentação de artigos científicos e projetos extencionistas dos alunos', '2026-08-10 09:00:00-03', '2026-08-12 17:00:00-03', 'Pavilhão Academico F', 24, 300, 'Planejamento', 2026, 2),
('Workshop: Startup Real', 'Aprenda a transformar a sua ideia academica em um negócio de sucesso', '2026-10-05 14:00:00-03', '2026-10-06 18:00:00-03', 'Auditório de Negócios', 8, 100, 'Planejamento', 2026, 3);

-- 3. Atividade
INSERT INTO atividade (nome_atividade, descricao, data, hora_inicio, hora_fim, local, capacidade, carga_horaria, id_evento) VALUES
('Palestra Magna: O impacto do GPT-5 no mercado', 'Abertura oficial discutindo as novas fronteiras da IA.', '2026-05-18', '09:00:00', '11:00:00', 'Teatro Principal', 400, 2, 1),
('Curso Intensivo: Arquitetura de Microsserviços', 'Prática hands-on desenhando sistemas resilientes baseados em nuvem.', '2026-05-19', '13:00:00', '17:00:00', 'Laboratório 03', 40, 4, 1),
('Palestra: Machine Learning na Prática Médica', 'Casos reais de identificação precoce de patologias com uso de IA.', '2026-05-20', '10:00:00', '12:00:00', 'Anfiteatro B', 120, 2, 1),
('Sessão Oral: Engenharia e Ciências Exatas', 'Apresentações dos resumos submetidos pelos alunos de graduação.', '2026-08-11', '09:00:00', '12:00:00', 'Sala de Videoconferência', 60, 3, 2),
('Curso Rápido: Pitch Perfeito para Investidores', 'Desenvolvimento de apresentações rápidas e impactantes para captação de recursos.', '2026-10-05', '15:00:00', '18:00:00', 'Mini Auditório', 40, 3, 3);

-- 4. Palestra
INSERT INTO palestra (titulo, data_palestra, hora_inicio, hora_fim, carga_horaria, id_atividade) VALUES
('O impacto do GPT-5 no mercado de Engenharia', '2026-05-18', '09:00:00', '11:00:00', 2, 1),
('Machine Learning aplicado à Triagem de Pacientes Médicos', '2026-05-20', '10:00:00', '12:00:00', 2, 3),
('Apresentações de Projetos Científicos - Bloco 1', '2026-08-11', '09:00:00', '12:00:00', 3, 4);

-- 5. Curso
INSERT INTO curso (nome_curso, descricao, id_atividade) VALUES
('Construindo Microsserviços Robustos com Spring Cloud', 'Configuração de Gateway, Service Discovery e Circuit Breakers.', 2),
('Modelagem de Negócios e Técnicas de Apresentação de Negócios (Pitch)', 'Como formatar um sumário executivo e apresentar para aceleradoras.', 5);

-- 6. Arquivo
INSERT INTO arquivo (nome_arquivo, tipo_arquivo, data_upload, id_palestra, id_curso) VALUES
('Slides_Introducao_IA.pdf', 'application/pdf', '2026-05-17', 1, NULL),
('Laboratorio_Spring_Cloud_Codigo.zip', 'application/zip', '2026-05-19', NULL, 1),
('Artigo_Morfologia_Celular_IA.pdf', 'application/pdf', '2026-05-19', 2, NULL);

-- 7. Local
INSERT INTO local (id_palestra, id_curso) VALUES
(1, 1),
(2, 1),
(3, 2);

-- 8. Sala
INSERT INTO sala (capacidade, recursos, id_local) VALUES
(30, 'Projetor HD, Quadro branco, Ar condicionado duplo', 1),
(50, 'Quadro interativo, Sistema de som embutido', 2);

-- 9. Auditorio
INSERT INTO auditorio (possui_palco, quantidade_assento, acessibilidade, id_local) VALUES
(TRUE, 250, 'Rampa de acesso lateral, espaço reservado para cadeirantes, intérprete de LIBRAS', 1),
(FALSE, 100, 'Elevador de acesso ao andar, assentos preferenciais', 3);

-- 10. Laboratorio
INSERT INTO laboratorio (nome_laboratorio, sistema_op, quantidade_computadores, id_local, id_curso) VALUES
('Laboratório de Desenvolvimento Avançado', 'Linux Ubuntu 22.04', 35, 2, 1),
('Laboratório Multimédia e Criação', 'Windows 11 / MacOS', 20, 1, 2);

-- 11. Usuario
INSERT INTO usuario (nome, sobrenome, email, senha, tipo_usuario) VALUES
('Carlos', 'Oliveira', 'carlos.oliveira@eventos.com', 'hash_senha_1', 'Organizador'),
('Beatriz', 'Santos', 'beatriz.santos@universidade.edu', 'hash_senha_2', 'Organizador'),
('Marcos', 'Pereira', 'marcos.p@gmail.com', 'hash_senha_3', 'Participante'),
('Aline', 'Souza', 'aline.souza@outlook.com', 'hash_senha_4', 'Participante'),
('Juliana', 'Costa', 'ju.costa@hotmail.com', 'hash_senha_5', 'Participante'),
('Roberto', 'Almeida', 'roberto.almeida@empresa.com', 'hash_senha_6', 'Participante'),
('Fernanda', 'Lima', 'fernanda.lima@Academico.com', 'hash_senha_7', 'Palestrante'),
('Ricardo', 'Mendes', 'ricardo.mendes@tech.io', 'hash_senha_8', 'Palestrante'),
('Patrícia', 'Fagundes', 'patricia.f@pesquisa.org', 'hash_senha_9', 'Palestrante'),
('Lucas', 'Ribeiro', 'lucas.ribeiro@estudante.com', 'hash_senha_10', 'Participante'),
('Mariana', 'Gomes', 'mariana.gomes@edu.com', 'hash_senha_11', 'Participante'),
('Gustavo', 'Martins', 'gustavo.m@dev.com', 'hash_senha_12', 'Participante');

-- 12. Usuario Telefone
INSERT INTO usuario_telefone (telefone, id_usuario) VALUES
('+5581999991111', 1),
('+5581999992222', 2),
('+5581988883333', 3),
('+558134455666', 3), 
('+5581987774444', 4),
('+5581986665555', 5),
('+5581985556666', 6),
('+5581974447777', 7),
('+5581973338888', 8),
('+5581972229999', 9),
('+5581961110000', 10),
('+5581962221111', 11),
('+5581963332222', 12);

-- 13. Participante
INSERT INTO participante (id_usuario, matricula, instituicao) VALUES
(3, '20231SI001', 'Universidade de Pernambuco'),
(4, '20222CC042', 'Universidade de Pernambuco'),
(5, '20241ENG09', 'Instituto Federal de Tecnologia'),
(6, 'EXT-99812', 'Empresa de Software'),
(10, '20232SI015', 'Universidade de Pernambuco'),
(11, '20211CC003', 'Universidade de Pernambuco'),
(12, 'EXT-55411', 'Consultoria Tech Nordeste');

-- 14. Organizador
INSERT INTO organizador (id_usuario, departamento, cargo, curso) VALUES
(1, 'Departamento de Informática', 'Coordenador de Eventos Extensão', 'Sistemas de Informação'),
(2, 'Pró-Reitoria de Acadêmica', 'Assistente Administrativo', 'Administração');

-- 15. Palestrante
INSERT INTO palestrante (id_usuario, curriculo_lattes, instituicao, biografia) VALUES
(7, 'http://lattes.cnpq.br/112233445566', 'Universidade de São Paulo (USP)', 'Doutora em Ciência da Computação, pesquisadora na área de Visão Computacional.'),
(8, 'http://lattes.cnpq.br/998877665544', 'Tech Enterprise Global', 'Engenheiro de Software Principal com mais de 12 years de experiência em arquiteturas Cloud Native.'),
(9, 'http://lattes.cnpq.br/445566778899', 'Fiocruz', 'Especialista em bioinformática e análise estatística de dados de saúde pública.');

-- 16. Inscricao
INSERT INTO inscricao (data_inscricao, status, id_usuario, id_atividade) VALUES
('2026-04-10', 'Confirmada', 3, 1),
('2026-04-10', 'Confirmada', 3, 2),
('2026-04-12', 'Confirmada', 4, 1),
('2026-04-12', 'Pendente', 4, 2),
('2026-04-15', 'Confirmada', 5, 1),
('2026-04-15', 'Confirmada', 5, 3),
('2026-04-20', 'Cancelada', 6, 2),
('2026-05-01', 'Confirmada', 10, 1),
('2026-05-01', 'Confirmada', 11, 1),
('2026-05-02', 'Confirmada', 12, 5);

-- 17. Presenca
INSERT INTO presenca (data_registro, status, id_inscricao, id_atividade) VALUES
('2026-05-18', 'Presente', 1, 1),
('2026-05-19', 'Presente', 2, 2),
('2026-05-18', 'Ausente', 3, 1),
('2026-05-18', 'Presente', 5, 1),
('2026-05-20', 'Presente', 6, 3),
('2026-05-18', 'Presente', 8, 1),
('2026-05-18', 'Presente', 9, 1);

-- 18. Certificado
INSERT INTO certificado (data_emissao, codigo_verificacao, carga_horaria, arquivo_certificado, id_presenca) VALUES
('2026-05-25', 'VALID-A1B2-C3D4-E5F6', 2, 'certificados/saida/cert_id_01.pdf', 1),
('2026-05-25', 'VALID-9988-7766-5544', 4, 'certificados/saida/cert_id_02.pdf', 2),
('2026-05-25', 'VALID-UUID-M771-K992', 2, 'certificados/saida/cert_id_05.pdf', 4);

-- 19. Pagamento
INSERT INTO pagamento (id_inscricao) VALUES
(1),
(2),
(3),
(4),
(10);

-- 20. Gratuito
INSERT INTO gratuito (id_pagamento, cota_social, motivo_isencao, comprovante_isencao) VALUES
(3, TRUE, 'Estudante de baixa renda cadastrado no CadÚnico', 'COMP_ISENCAO_44321_PDF'),
(5, FALSE, 'Isenção garantida para monitores voluntários do evento', 'PORTARIA_PROEXT_012_2026');

-- 21. Pago
INSERT INTO pago (id_pagamento, valor, opcao_pagamento, data_vencimento, comprovante) VALUES
(1, 25.50, 'PIX', '2026-04-15', 'COMP-992110293-X'),
(2, 70.00, 'Cartão de Crédito', '2026-04-15', 'COMP-883210234-Y'),
(4, 70.00, 'Boleto Bancário', '2026-04-20', NULL);

-- 22. Patrocinador
INSERT INTO patrocinador (nome_patrocinador, cnpj) VALUES
('Banco Digital Nacional', '12345678000100'),
('Inovação Tecnologias S.A', '98765432000199'),
('Editora Livros Academicos', '45678912000188'),
('Café Gourmet Recife', '78912345000122');

-- 23. Evento Organizado
INSERT INTO evento_organizado (funcao, id_usuario, id_evento) VALUES
('Coordenador Geral', 1, 1),
('Apoio de Logística', 2, 1),
('Coordenador Geral', 2, 2),
('Presidente da Banca', 1, 2),
('Coordenador Operacional', 1, 3);

-- 24. Evento Patrocinador
INSERT INTO evento_patrocinador (tipo_cota, valor_cota, id_evento, id_patrocinador) VALUES
('Cota Diamante', 15000, 1, 1),
('Cota Ouro', 8000, 1, 2),
('Cota Bronze', 2000, 1, 4),
('Cota Prata', 5000, 2, 3),
('Cota Ouro', 10000, 3, 2);