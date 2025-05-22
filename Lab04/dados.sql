-- Inserindo dados na ordem correta para respeitar as chaves estrangeiras

-- 1. Institui��es
INSERT INTO Instituicoes (nome, sigla, cidade, estado, tipo, data_fundacao) VALUES
('Universidade Federal de Tecnologia', 'UFT', 'S�o Paulo', 'SP', 'Federal', '1960-05-15'),
('Faculdade de Ensino Superior', 'FES', 'Rio de Janeiro', 'RJ', 'Privada', '1985-03-20'),
('Instituto Estadual de Educa��o', 'IEE', 'Belo Horizonte', 'MG', 'Estadual', '1972-11-10');

-- 2. Cursos
INSERT INTO Cursos (id_instituicao, nome, duracao_anos, area) VALUES
(1, 'Engenharia de Software', 5, 'Tecnologia'),
(1, 'Administra��o', 4, 'Humanas'),
(2, 'Medicina', 6, 'Biol�gicas'),
(3, 'Matem�tica', 4, 'Exatas');

-- 3. Turmas (CORRIGIDO o valor 'Integral' para 'Integral')
INSERT INTO Turmas (id_curso, ano_letivo, semestre, periodo, quantidade_alunos) VALUES
(1, 2023, '1', 'Noturno', 30),
(1, 2023, '2', 'Noturno', 28),
(2, 2023, '1', 'Matutino', 40),
(3, 2023, '1', 'Integral', 25),
(4, 2023, '2', 'Vespertino', 35);

-- 4. Disciplinas
INSERT INTO Disciplinas (nome, carga_horaria, ementa, area_conhecimento) VALUES
('Programa��o I', 60, 'Introdu��o � l�gica de programa��o', 'Computa��o'),
('Banco de Dados', 80, 'Modelagem e implementa��o de bancos de dados', 'Computa��o'),
('Anatomia Humana', 120, 'Estudo da estrutura do corpo humano', 'Medicina'),
('C�lculo I', 90, 'Limites, derivadas e integrais', 'Matem�tica'),
('Gest�o de Projetos', 60, 'Planejamento e execu��o de projetos', 'Administra��o');

-- 5. Professores (ALTERADO os CPFs para evitar duplicidade)
INSERT INTO Professores (id_instituicao, nome, cpf, data_nascimento, data_contratacao, titulacao, salario) VALUES
(1, 'Carlos Silva', '11122233344', '1975-08-12', '2010-03-15', 'Doutorado', 8500.00),
(1, 'Ana Oliveira', '22233344455', '1982-05-23', '2015-07-20', 'Mestrado', 7200.00),
(2, 'Roberto Santos', '33344455566', '1968-11-30', '2008-02-10', 'Doutorado', 9800.00),
(3, 'Juliana Costa', '44455566677', '1979-04-17', '2012-08-05', 'Mestrado', 6800.00);

-- 6. Alunos (AGORA inserindo ap�s as turmas estarem criadas)
INSERT INTO Alunos (id_turma, nome, cpf, data_nascimento, email, telefone, endereco) VALUES
(1, 'Jo�o Pereira', '55566677788', '2000-07-15', 'joao@email.com', '11987654321', 'Rua A, 123 - S�o Paulo'),
(1, 'Maria Souza', '66677788899', '2001-03-22', 'maria@email.com', '11976543210', 'Av. B, 456 - S�o Paulo'),
(2, 'Pedro Oliveira', '77788899900', '1999-11-10', 'pedro@email.com', '21965432109', 'Rua C, 789 - Rio de Janeiro'),
(3, 'Ana Santos', '88899900011', '2002-05-18', 'ana@email.com', '21954321098', 'Av. D, 101 - Rio de Janeiro'),
(4, 'Lucas Costa', '99900011122', '2000-09-30', 'lucas@email.com', '31943210987', 'Rua E, 202 - Belo Horizonte');

-- 7. Matr�culas (AGORA inserindo ap�s alunos e disciplinas estarem criadas)
INSERT INTO Matriculas (id_aluno, id_disciplina, id_turma, ano, semestre, situacao) VALUES
(1, 1, 1, 2023, '1', 'Aprovado'),
(1, 2, 1, 2023, '2', 'Cursando'),
(2, 1, 1, 2023, '1', 'Aprovado'),
(2, 2, 1, 2023, '2', 'Cursando'),
(3, 4, 2, 2023, '1', 'Reprovado'),
(4, 3, 3, 2023, '1', 'Aprovado'),
(5, 5, 4, 2023, '2', 'Cursando');

-- 8. Notas (AGORA inserindo ap�s matr�culas estarem criadas)
INSERT INTO Notas (id_matricula, nota_bimestre1, nota_bimestre2, nota_bimestre3, nota_bimestre4, media_final, faltas) VALUES
(1, 8.5, 7.0, 9.2, 8.8, 8.4, 2),
(2, 6.0, 7.5, NULL, NULL, NULL, 1),
(3, 7.8, 8.2, 9.0, 8.5, 8.4, 0),
(4, 5.5, 4.0, 6.2, 5.8, 5.4, 5),
(5, 9.0, 9.5, 9.8, 9.2, 9.4, 1),
(6, 4.0, 3.5, 5.0, 4.5, 4.3, 8);

-- 9. Professores por Disciplina (AGORA inserindo ap�s todas as tabelas relacionadas estarem criadas)
INSERT INTO ProfessorDisciplina (id_professor, id_disciplina, id_turma, ano, semestre) VALUES
(1, 1, 1, 2023, '1'),
(1, 2, 1, 2023, '2'),
(2, 4, 2, 2023, '1'),
(3, 3, 3, 2023, '1'),
(4, 5, 4, 2023, '2');
GO