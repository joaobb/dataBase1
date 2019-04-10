CREATE TYPE ESTADO AS ('MA', 'PI', 'CE', 'RN', 'PE', 'PB', 'SE', 'AL', 'BA');
CREATE TYPE FUNC_TYPE AS ('FARMACÊUTICOS', 'VENDEDORES', 'ENTREGADORES', 'CAIXAS', 'ADMINISTRADOR');
CREATE TYPE TIPO_ENDERECO AS ('RESIDÊNCIA', 'TRABALHO', 'OUTRO');

CREATE TABLE farmacia (
    nome TEXT,
    cnpj CHAR(15),
    bairro TEXT,
    cidade TEXT,
    estado ESTADO,
    gerente_cpf CHAR(11),
    sede BOOLEAN
);


CREATE TABLE funcionario (
    cpf CHAR(11),
    tipo FUNC_TYPE,
    farmacia_trabalho CHAR(15) REFERENCES farmacia(cnpj),

);

CREATE TABLE medicamento (
    nome TEXT,
    id INTEGER,
    restrito BOOLEAN,

);

CREATE TABLE venda (

);

CREATE TABLE entega (
    id INTEGER PRIMARY KEY,
    cpf 
);

CREATE TABLE cliente (
    nome TEXT,
    cpf CHAR(11),

);

CREATE TABLE endereco_cliente (
    id INTEGER,
    endereco TEXT,
    tipo TIPO_ENDERECO,

);