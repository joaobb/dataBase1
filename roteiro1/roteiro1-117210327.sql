--questao_1

CREATE TABLE automovel (
Aplaca VARCHAR(8) PRIMARY KEY,
Aestado CHAR(2),
Aano_de_fabricacao INTEGER(4),
Anum_chassi CHAR(17),
Amodelo TEXT,
Amarca TEXT);

CREATE TABLE segurado (
Snome TEXT,
STelefone INTEGER(11),
Scpf INTEGER(11) PRIMARY KEY,
Sdata_de_nascimento DATE,
Aplaca VARCHAR(8) REFERENCES automovel (placa));

CREATE TABLE perito (
Pnome TEXT,
Pestado CHAR(2),
Pcpf INTEGER(11),
Pid INTEGER(10)) PRIMARY KEY;

CREATE TABLE oficina (
Onome_fantasia TEXT,
Otelefone INTEGER(10),
Ocnpj INTEGER(14) PRIMARY KEY,
Ocep INTEGER(8));

CREATE TABLE seguro (
Sid INTEGER(10) PRIMARY KEY,
Splano TEXT,
Svalor NUMERIC,
Sinicio DATE,
Ssegurado_cpf INTEGER(11),
Aplaca VARCHAR(8),
FOREIGN KEY (Ssegurado_cpf, Aplaca) REFERENCES segurado (Scpf, Aplaca));

CREATE TABLE sinistro (
Sid INTEGER(10),
Ppericia_id INTEGER(10) REFERENCES pericia(Pid),
Stime_stamp TIMESTAMP,
Sseguro_id INTEGER(10) REFERENCES seguro (sid),
Svitimas BOOLEAN);

CREATE TABLE pericia (
Pid INTEGER(10), 
Perito_id INTEGER(10) REFERENCES perito(Pid),
Sin_id INTEGER(10) REFERENCES sinistro(Sid),
Pdescricao TEXT,
Ptime TIMESTAMP);
