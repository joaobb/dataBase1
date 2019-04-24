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
ALTER TABLE tarefas ADD CONSTRAINT possibleStatus CHECK (status = 'P' OR status = 'E' OR status = 'C');
            
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
ALTER TABLE funcionario ADD CONSTRAINT cpf_size CHECK (LENGTH(cpf) = 11);
ALTER TABLE funcionario ADD CONSTRAINT invalid_nivel CHECK(nivel = 'J' OR nivel = 'P' OR nivel = 'S');


INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', null);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'J', '12345678911');

INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678913', '1980-04-09', 'joao da Silva', 'LIMPEZA', 'J', null);
--ERROR:  new row for relation "funcionario" violates check constraint "has_sup"
--DETAIL:  Failing row contains (12345678913, 1980-04-09, joao da Silva, LIMPEZA, J, null).

--questao_9
---10 exemplos corretos
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('38957494064', '2000-9-18', 'Samuel', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('92724485167', '1956-12-2', 'Igor', 'SUP_LIMPEZA', 'J', NULL);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('92248101412', '1969-12-18', 'Paulo', 'SUP_LIMPEZA', 'J', NULL);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('58392438031', '1975-11-29', 'Bianca', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('48224677798', '1979-4-23', 'Yasmin', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('59740984233', '1984-10-13', 'Alice', 'LIMPEZA', 'S', '92248101412');
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('20225191315', '2006-4-13', 'Sarah', 'LIMPEZA', 'S', '92724485167');
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('96078200801', '1951-10-23', 'Marcos', 'LIMPEZA', 'J', '12345678911');
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('24021674430', '1968-2-15', 'Matheus', 'LIMPEZA', 'P', '92724485167');
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('58392434843', '1975-04-10', 'Jorge', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('81378200801', '1949-11-10', 'Campelo', 'LIMPEZA', 'S', '58392438031');

---
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('38957494064', '2000-9-18', 'Rafael', 'LIMPEZA', 'S', NULL);          --Limpeza sem superior
--ERROR:  new row for relation "funcionario" violates check constraint "has_sup"
--DETAIL:  Failing row contains (38957494064, 2000-09-18, Rafael, LIMPEZA, S, null).
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('92724485167', '1956-12-2', 'Soraya', 'SUP_LIMPEZA', 'J', NULL);      --CPF repetido
--ERROR:  duplicate key value violates unique constraint "funcionario_pkey"
--DETAIL:  Key (cpf)=(92724485167) already exists.
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('922481014129', '1969-12-18', 'Paulo', 'SUP_LIMPEZA', 'J', NULL);     --CPF com mais digitos do que permitido
--ERROR:  value too long for type character(11)
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('5839243803', '1975-11-29', 'Bianca', 'SUP_LIMPEZA', 'P', NULL);      --CPF com menos digitos do que permitido
--ERROR:  new row for relation "funcionario" violates check constraint "cpf_size"
--DETAIL:  Failing row contains (5839243803 , 1975-11-29, Bianca, SUP_LIMPEZA, P, null).
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('59740984243', '1984-10-13', 'Alice', 'LIMPEZA', 'S', 18348132782);   --Superior nao cadastrado no sistema
--ERROR:  insert or update on table "funcionario" violates foreign key constraint "funcionario_superior_cpf_fkey"
--DETAIL:  Key (superior_cpf)=(18348132782) is not present in table "funcionario".
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('20225291315', '2006-4-13', 'Sarah', 'LIMPEZA', 'H', 92724485167);    --Nivel fora do padrao
--ERROR:  new row for relation "funcionario" violates check constraint "invalid_nivel"
--DETAIL:  Failing row contains (20225291315, 2006-04-13, Sarah, LIMPEZA, H, 92724485167).
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('96078210801', '1951-10-23', 'Marcos', 'LIMPEZA', '', 12345678911);   --Nivel vazio
--ERROR:  new row for relation "funcionario" violates check constraint "invalid_nivel"
--DETAIL:  Failing row contains (96078210801, 1951-10-23, Marcos, LIMPEZA,  , 12345678911).
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('24021674430', '1968-2-15', 'Matheus', 'LIMPEZA', 'PP', 92724485167); --Nivel maior do que o permitido
--ERROR:  value too long for type character(1)
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES(NULL, '1975-04-10', 'Jorge', 'SUP_LIMPEZA', 'P', NULL);               --Chave primaria NULA
--ERROR:  null value in column "cpf" violates not-null constraint
--DETAIL:  Failing row contains (null, 1975-04-10, Jorge, SUP_LIMPEZA, P, null).
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES(NULL, NULL, NULL, NULL, NULL, NULL);                                  --Tudo errado
--ERROR:  null value in column "cpf" violates not-null constraint
--DETAIL:  Failing row contains (null, null, null, null, null, null).

--questao_10
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('32323232911', '1988-10-12', 'Takeo', 'LIMPEZA', 'P', '58392438031');
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('98765432122', '1996-02-29', 'Otori', 'LIMPEZA', 'S', '92248101412'); --O sql verifica se o ano e bissexto
INSERT INTO funcionario(cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES('98765432111', '1999-05-15', 'Ghanor', 'LIMPEZA', 'J', '38957494064');
ALTER TABLE tarefas ADD CONSTRAINT func_cpf_fkey FOREIGN KEY (func_resp_cpf) REFERENCES funcionario (cpf) ON DELETE CASCADE;

DELETE FROM funcionario WHERE cpf = '32323232911';
ALTER TABLE tarefas DROP CONSTRAINT func_cpf_fkey;
ALTER TABLE tarefas ADD CONSTRAINT func_cpf_restrict_fkey FOREIGN KEY (func_resp_cpf) REFERENCES funcionario (cpf) ON DELETE RESTRICT;
DELETE FROM funcionario WHERE cpf = '98765432111';
--ERROR:  update or delete on table "funcionario" violates foreign key constraint "func_cpf_restrict_fkey" on table "tarefas"
--DETAIL:  Key (cpf)=(98765432111) is still referenced from table "tarefas".

--questao_11
ALTER TABLE tarefas ADD CONSTRAINT status_validity CHECK((status = 'E' AND func_resp_cpf IS NOT NULL) OR (status = 'P' OR status = 'C'));
ALTER TABLE tarefas DROP CONSTRAINT func_cpf_restrict_fkey;
ALTER TABLE tarefas ADD CONSTRAINT func_cpf_fkey_set_null FOREIGN KEY (func_resp_cpf) REFERENCES funcionario (cpf) ON DELETE SET NULL;

INSERT INTO tarefas VALUES (2147483657, 'limpar as lagrimas da sala de prova','81378200801', 5, 'E');
DELETE FROM funcionario WHERE cpf IN (SELECT func_resp_cpf FROM tarefas WHERE status = 'E');
--ERROR:  null value in column "func_resp_cpf" violates not-null constraint
--DETAIL:  Failing row contains (2147483657, limpar as lagrimas da sala de prova, null, 5, E).
--CONTEXT:  SQL statement "UPDATE ONLY "public"."tarefas" SET "func_resp_cpf" = NULL WHERE $1 OPERATOR(pg_catalog.=) "func_resp_cpf""
