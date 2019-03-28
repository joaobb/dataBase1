CREATE TABLE tarefas(
id INTEGER,
descricao TEXT,
func_resp_cpf CHAR(11),
prioridade INTEGER,
status CHAR(1));

ALTER TABLE tarefas ADD CONSTRAINT id_negativo CHECK (id > 0);

--questao_1
INSERT INTO tarefas VALUES (2147483646, 'limpar chão do corredor central','98765432111', 0, 'F');
INSERT INTO tarefas VALUES (2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'F');
INSERT INTO tarefas VALUES (null, null, null, null, null);
INSERT INTO tarefas VALUES (2147483644, 'limpar chão do corredor superior','987654323211', 0, 'F');
-->ERROR:  value too long for type character(11)
INSERT INTO tarefas VALUES (2147483643, 'limpar chão do corredor superior','98765432321', 0, 'FF');
-->ERROR:  value too long for type character(1)

--questao_2
INSERT INTO tarefas VALUES (2147483648, 'limpar portas do térreo', '32323232955', 4,'A');
-->ERROR:  integer out of range
ALTER TABLE tarefas ALTER COLUMN id TYPE BIGINT;

--questao_3
INSERT INTO tarefas VALUES (2147483649, 'limpar portas da entrada principal','32322525199', 32768, 'A');
-->INSERT 0 1
INSERT INTO tarefas VALUES (2147483650, 'limpar janelas da entrada principal', '32333233288', 32769, 'A');
-->INSERT 0 1
DELETE FROM tarefas WHERE prioridade > 32767;
ALTER TABLE tarefas ALTER COLUMN prioridade TYPE SMALLINT;

--questao_4
DELETE FROM tarefas WHERE descricao IS null;
ALTER TABLE tarefas ALTER COLUMN id SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN descricao SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN func_resp_cpf SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN prioridade SET NOT NULL;
ALTER TABLE tarefas ALTER COLUMN status SET NOT NULL;

--questao_5
INSERT INTO tarefas VALUES (2147483653, 'limpar portas do 1o andar','32323232911',2,'A');
INSERT INTO tarefas VALUES (2147483653, 'aparar a grama da área frontal','32323232911', 3, 'A');
--INSERT 0 1
DELETE FROM tarefas WHERE (id = 2147483653 AND descricao = 'limpar portas do 1o andar');
--DELETE 1
ALTER TABLE tarefas ADD CONSTRAINT tarefas_pk PRIMARY KEY (id, func_resp_cpf);

--questao_6
---a)
INSERT INTO tarefas VALUES (2147483658, 'limpar portas do 1o andar','323232324832',1,'A');
--ERROR:  value too long for type character(11)
---Ja ha a impossibilidade de insercao de CPFs de tamanhos destintos de 11, pelo fato,
---do atributo ter sido definindo com CHAR(11), logo, este apenas aceita valores com 11 chars.
ALTER TABLE tarefas ADD CONSTRAINT cpf_validity CHECK (LENGTH(func_resp_cpf) = 11);

---b)
ALTER TABLE tarefas ADD CONSTRAINT possibleStatus CHECK (status = 'P' OR status = 'E' OR status = 'C');
--ERROR:  check constraint "possiblestatus" is violated by some row

UPDATE tarefas SET status = 'P' WHERE status = 'A';
UPDATE tarefas SET status = 'E' WHERE status = 'R';
UPDATE tarefas SET status = 'C' WHERE status = 'F';

--questao_7
DELETE FROM tarefas WHERE (prioridade > 5 OR prioridade < 0);
ALTER TABLE tarefas ADD CONSTRAINT priority_limit CHECK(prioridade >= 0 OR prioridade <= 5);

--questao_8
CREATE TABLE funcionario(
    cpf CHAR(11) PRIMARY KEY,
    data_nasc DATE,
    nome TEXT,
    funcao TEXT,
    nivel CHAR(1),
    superior_cpf CHAR(11) REFERENCES funcionario(cpf)
);

ALTER TABLE funcionario ADD CONSTRAINT has_sup CHECK ((funcao = 'LIMPEZA' AND superior_cpf IS NOT NULL) OR (funcao = 'SUP_LIMPEZA'));



INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'J', '12345678911');

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678913', '1980-04-09', 'joao da Silva', 'LIMPEZA', 'J', null);
--ERROR:  new row for relation "funcionario" violates check constraint "has_sup"
--DETAIL:  Failing row contains (12345678913, 1980-04-09, joao da Silva, LIMPEZA, J, null).

--questao_9
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('38957494064', '2000-9-18', 'Samuel', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('92724485167', '1956-12-2', 'Igor', 'SUP_LIMPEZA', 'J', NULL);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('92248101412', '1969-12-18', 'Paulo', 'SUP_LIMPEZA', 'J', NULL);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('58392438031', '1975-11-29', 'Bianca', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('48224677798', '1979-4-23', 'Yasmin', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('59740984233', '1984-10-13', 'Alice', 'LIMPEZA', 'S', 92248101412);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('20225191315', '2006-4-13', 'Sarah', 'LIMPEZA', 'S', 92724485167);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('96078200801', '1951-10-23', 'Marcos', 'LIMPEZA', 'J', 12345678911);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('24021674430', '1968-2-15', 'Matheus', 'LIMPEZA', 'P', 92724485167);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('58392434843', '1975-04-10', 'Jorge', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('81378200801', '1949-11-10', 'Campelo', 'LIMPEZA', 'S', 58392438031);