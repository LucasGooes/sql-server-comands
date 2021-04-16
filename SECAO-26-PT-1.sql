/*CONECTANDO A UM BANCO*/
USE EMPRESA
GO
/*CRIA��O DE TABELAS*/
CREATE TABLE ALUNO(
	IDALUNO INT PRIMARY KEY IDENTITY,
	NOME VARCHAR(30) NOT NULL,
	SEXO CHAR(1) NOT NULL,
	NASCIMENTO DATE NOT NULL,
	EMAIL VARCHAR(30) UNIQUE,
)
GO
/*CONSTRAINTS*/
ALTER TABLE ALUNO
ADD CONSTRAINT CK_SEXO CHECK(SEXO IN('M','F'))
GO
/* 1 X 1 */
CREATE TABLE ENDERECO(
	IDENDERECO INT PRIMARY KEY IDENTITY(100,10),
	BAIRRO VARCHAR(30),
	UF CHAR(2) NOT NULL
	CHECK(UF IN('RJ','SP','MG')),
	ID_ALUNO INT UNIQUE
)
GO
/*CRIANDO A FK*/
ALTER TABLE ENDERECO ADD CONSTRAINT FK_ENDERECO_ALUNO
FOREIGN KEY(ID_ALUNO) REFERENCES ALUNO(IDALUNO)
GO
/*COMANDOS DE DESCRI��O*/
/*PROCEDURES - JA CRIADAS E ARMAZENADAS NO SISTEMA*/
SP_COLUMNS ALUNO
GO

SP_HELP ALUNO
GO

/*INSERINDO DADOS*/
INSERT INTO ALUNO VALUES('ANDRE','M','1981/12/09','ANDRE@IG.COM')
INSERT INTO ALUNO VALUES('ANA','F','1989/05/29','ANA@HOTMAIL.COM')
INSERT INTO ALUNO VALUES('FELIPE','M','1999/10/02','FELIPE@GMAIL.COM')
INSERT INTO ALUNO VALUES('LUCAS','M','2000/12/25','LUCAS@IG.COM')
INSERT INTO ALUNO VALUES('MARIA','F','1965/01/01','MARIA@GMAIL.COM')
GO
SELECT * FROM ALUNO
GO
/*ENDERECO*/
INSERT INTO ENDERECO VALUES('FLAMENGO','RJ',1)
INSERT INTO ENDERECO VALUES('MORUMBI','SP',2)
INSERT INTO ENDERECO VALUES('CENTRO','MG',3)
INSERT INTO ENDERECO VALUES('CENTRO','SP',4)
GO
SELECT * FROM ENDERECO
GO
/*CREATE TABLE TELEFONE*/
CREATE TABLE TELEFONE(
	IDTELEFONE INT PRIMARY KEY IDENTITY,
	TIPO CHAR(3) NOT NULL,
	NUMERO VARCHAR(10) NOT NULL,
	ID_ALUNO INT,
	CHECK (TIPO IN('RES','COM','CEL'))
)
GO
INSERT INTO TELEFONE VALUES('CEL','78985545',1)
INSERT INTO TELEFONE VALUES('RES','42265985',1)
INSERT INTO TELEFONE VALUES('COM','89968877',2)
INSERT INTO TELEFONE VALUES('CEL','54558899',2)
GO

SELECT * FROM ALUNO
GO

/*PEGAR DATA ATUAL DO SISTEMA*/
SELECT GETDATE()
GO
/*CLAUSULA AMBIGUA*/
SELECT A.NOME, T.TIPO, T.NUMERO, E.BAIRRO, E.UF
FROM ALUNO A LEFT JOIN TELEFONE T
ON A.IDALUNO = T.ID_ALUNO
INNER JOIN ENDERECO E
ON A.IDALUNO = E.ID_ALUNO
GO
/*ISNULL*/
SELECT A.NOME, ISNULL(T.TIPO,'S/TEL'), ISNULL(T.NUMERO,'S/NUM'), E.BAIRRO, E.UF
FROM ALUNO A LEFT JOIN TELEFONE T
ON A.IDALUNO = T.ID_ALUNO
INNER JOIN ENDERECO E
ON A.IDALUNO = E.ID_ALUNO
GO
/*DATAS*/
SELECT * FROM ALUNO
GO

SELECT NOME, NASCIMENTO
FROM ALUNO
GO

/*DATEDIFF - CALCULA A DIFEREN�A ENTRE 2 DATAS*/
/* 1 PASSO*/
SELECT NOME, DATEDIFF(DAY,NASCIMENTO,GETDATE())
FROM ALUNO
GO
/* 2 PASSO*/
SELECT NOME, DATEDIFF(YEAR,NASCIMENTO,GETDATE()) AS "IDADE"
FROM ALUNO
GO

/*DATENAME - TRAZ O NOME DA PARTE DA DATA EM QUESTAO(STRING)*/
SELECT NOME, DATENAME(MONTH, NASCIMENTO) AS "M�S"
FROM ALUNO
GO
SELECT NOME, DATENAME(YEAR, NASCIMENTO) AS "ANO"
FROM ALUNO
GO
SELECT NOME, DATENAME(DAY, NASCIMENTO) AS "DIA"
FROM ALUNO
GO
/*DATEPART - - DATENAME POR�M O RETORNO � INTEIRO*/
SELECT NOME, DATEPART(YEAR, NASCIMENTO)
FROM ALUNO
GO
/*DATEADD - RETORNA UMA DATA SOMANDO A OUTRA DATA*/
SELECT DATEADD(DAY,365,GETDATE())