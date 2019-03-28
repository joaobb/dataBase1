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