-- View para análise de desempenho dos alunos
CREATE VIEW vw_DesempenhoAlunos AS
SELECT 
    a.nome AS aluno,
    d.nome AS disciplina,
    t.ano_letivo,
    t.semestre,
    n.nota_bimestre1,
    n.nota_bimestre2,
    n.nota_bimestre3,
    n.nota_bimestre4,
    n.media_final,
    n.faltas,
    m.situacao,
    c.nome AS curso,
    i.nome AS instituicao
FROM Alunos a
JOIN Matriculas m ON a.id_aluno = m.id_aluno
JOIN Notas n ON m.id_matricula = n.id_matricula
JOIN Disciplinas d ON m.id_disciplina = d.id_disciplina
JOIN Turmas t ON m.id_turma = t.id_turma
JOIN Cursos c ON t.id_curso = c.id_curso
JOIN Instituicoes i ON c.id_instituicao = i.id_instituicao;
GO

-- View para análise de professores
CREATE VIEW vw_DesempenhoProfessores AS
SELECT 
    p.nome AS professor,
    d.nome AS disciplina,
    t.ano_letivo,
    t.semestre,
    COUNT(m.id_aluno) AS quantidade_alunos,
    AVG(n.media_final) AS media_turma,
    p.titulacao,
    i.nome AS instituicao
FROM Professores p
JOIN ProfessorDisciplina pd ON p.id_professor = pd.id_professor
JOIN Disciplinas d ON pd.id_disciplina = d.id_disciplina
JOIN Turmas t ON pd.id_turma = t.id_turma
JOIN Matriculas m ON t.id_turma = m.id_turma AND d.id_disciplina = m.id_disciplina
JOIN Notas n ON m.id_matricula = n.id_matricula
JOIN Instituicoes i ON p.id_instituicao = i.id_instituicao
GROUP BY p.nome, d.nome, t.ano_letivo, t.semestre, p.titulacao, i.nome;
GO

-- View para análise institucional
CREATE VIEW vw_AnaliseInstitucional AS
SELECT 
    i.nome AS instituicao,
    i.tipo,
    i.cidade,
    i.estado,
    COUNT(DISTINCT c.id_curso) AS quantidade_cursos,
    COUNT(DISTINCT t.id_turma) AS quantidade_turmas,
    COUNT(DISTINCT a.id_aluno) AS quantidade_alunos,
    COUNT(DISTINCT p.id_professor) AS quantidade_professores
FROM Instituicoes i
LEFT JOIN Cursos c ON i.id_instituicao = c.id_instituicao
LEFT JOIN Turmas t ON c.id_curso = t.id_curso
LEFT JOIN Alunos a ON t.id_turma = a.id_turma
LEFT JOIN Professores p ON i.id_instituicao = p.id_instituicao
GROUP BY i.nome, i.tipo, i.cidade, i.estado;
GO