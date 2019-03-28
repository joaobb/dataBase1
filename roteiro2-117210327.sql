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
ALTER TABLE tarefas ALTER COLUMN * SET NOT NULL;