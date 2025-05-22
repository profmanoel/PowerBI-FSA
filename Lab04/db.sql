-- Criação do banco de dados (se necessário)
USE master;
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'AnaliseEducacional')
BEGIN
    ALTER DATABASE AnaliseEducacional SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE AnaliseEducacional;
END
GO
CREATE DATABASE AnaliseEducacional;
GO

USE AnaliseEducacional;
GO

-- Tabela de Instituições
CREATE TABLE Instituicoes (
    id_instituicao INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    sigla VARCHAR(10),
    cidade VARCHAR(50) NOT NULL,
    estado CHAR(2) NOT NULL,
    tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('Pública', 'Privada', 'Federal', 'Estadual', 'Municipal')),
    data_fundacao DATE
);

-- Tabela de Cursos
CREATE TABLE Cursos (
    id_curso INT PRIMARY KEY IDENTITY(1,1),
    id_instituicao INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    duracao_anos INT NOT NULL,
    area VARCHAR(20) NOT NULL CHECK (area IN ('Exatas', 'Humanas', 'Biológicas', 'Tecnologia', 'Artes')),
    CONSTRAINT FK_Cursos_Instituicoes FOREIGN KEY (id_instituicao) REFERENCES Instituicoes(id_instituicao)
);

-- Tabela de Turmas (CORRIGIDO o nome da coluna 'periodo')
CREATE TABLE Turmas (
    id_turma INT PRIMARY KEY IDENTITY(1,1),
    id_curso INT NOT NULL,
    ano_letivo INT NOT NULL,
    semestre CHAR(1) NOT NULL CHECK (semestre IN ('1', '2')),
    periodo VARCHAR(20) NOT NULL CHECK (periodo IN ('Matutino', 'Vespertino', 'Noturno', 'Integral')),
    quantidade_alunos INT DEFAULT 0,
    CONSTRAINT FK_Turmas_Cursos FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso)
);

-- Tabela de Disciplinas
CREATE TABLE Disciplinas (
    id_disciplina INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(100) NOT NULL,
    carga_horaria INT NOT NULL,
    ementa TEXT,
    area_conhecimento VARCHAR(50)
);

-- Tabela de Professores (ALTERADO para evitar duplicidade de CPF)
CREATE TABLE Professores (
    id_professor INT PRIMARY KEY IDENTITY(1,1),
    id_instituicao INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE,
    data_nascimento DATE,
    data_contratacao DATE NOT NULL,
    titulacao VARCHAR(20) NOT NULL CHECK (titulacao IN ('Graduação', 'Especialização', 'Mestrado', 'Doutorado')),
    salario DECIMAL(10,2),
    CONSTRAINT FK_Professores_Instituicoes FOREIGN KEY (id_instituicao) REFERENCES Instituicoes(id_instituicao)
);

-- Tabela de Alunos
CREATE TABLE Alunos (
    id_aluno INT PRIMARY KEY IDENTITY(1,1),
    id_turma INT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) UNIQUE,
    data_nascimento DATE,
    email VARCHAR(100),
    telefone VARCHAR(20),
    endereco TEXT,
    CONSTRAINT FK_Alunos_Turmas FOREIGN KEY (id_turma) REFERENCES Turmas(id_turma)
);

-- Tabela de Matrículas
CREATE TABLE Matriculas (
    id_matricula INT PRIMARY KEY IDENTITY(1,1),
    id_aluno INT NOT NULL,
    id_disciplina INT NOT NULL,
    id_turma INT NOT NULL,
    ano INT NOT NULL,
    semestre CHAR(1) NOT NULL CHECK (semestre IN ('1', '2')),
    situacao VARCHAR(20) DEFAULT 'Cursando' CHECK (situacao IN ('Cursando', 'Aprovado', 'Reprovado', 'Trancado')),
    CONSTRAINT FK_Matriculas_Alunos FOREIGN KEY (id_aluno) REFERENCES Alunos(id_aluno),
    CONSTRAINT FK_Matriculas_Disciplinas FOREIGN KEY (id_disciplina) REFERENCES Disciplinas(id_disciplina),
    CONSTRAINT FK_Matriculas_Turmas FOREIGN KEY (id_turma) REFERENCES Turmas(id_turma)
);

-- Tabela de Notas
CREATE TABLE Notas (
    id_nota INT PRIMARY KEY IDENTITY(1,1),
    id_matricula INT NOT NULL,
    nota_bimestre1 DECIMAL(4,2),
    nota_bimestre2 DECIMAL(4,2),
    nota_bimestre3 DECIMAL(4,2),
    nota_bimestre4 DECIMAL(4,2),
    media_final DECIMAL(4,2),
    faltas INT DEFAULT 0,
    CONSTRAINT FK_Notas_Matriculas FOREIGN KEY (id_matricula) REFERENCES Matriculas(id_matricula)
);

-- Tabela de Professores por Disciplina
CREATE TABLE ProfessorDisciplina (
    id_professor_disciplina INT PRIMARY KEY IDENTITY(1,1),
    id_professor INT NOT NULL,
    id_disciplina INT NOT NULL,
    id_turma INT NOT NULL,
    ano INT NOT NULL,
    semestre CHAR(1) NOT NULL CHECK (semestre IN ('1', '2')),
    CONSTRAINT FK_ProfessorDisciplina_Professores FOREIGN KEY (id_professor) REFERENCES Professores(id_professor),
    CONSTRAINT FK_ProfessorDisciplina_Disciplinas FOREIGN KEY (id_disciplina) REFERENCES Disciplinas(id_disciplina),
    CONSTRAINT FK_ProfessorDisciplina_Turmas FOREIGN KEY (id_turma) REFERENCES Turmas(id_turma)
);
GO