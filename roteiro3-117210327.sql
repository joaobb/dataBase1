CREATE TYPE ESTADO AS ENUM('MA', 'PI', 'CE', 'RN', 'PE', 'PB', 'SE', 'AL', 'BA');
CREATE TYPE FUNC_TYPE AS ENUM('FARMACEUTICO', 'VENDEDOR', 'ENTREGADOR', 'CAIXA', 'ADMINISTRADOR');
CREATE TYPE TIPO_ENDERECO AS ENUM('RESIDENCIA', 'TRABALHO', 'OUTRO');

CREATE TABLE funcionarios (
    nome TEXT,
    cpf CHAR(11) PRIMARY KEY,
    tipo FUNC_TYPE NOT NULL,
    farmacia_trabalho INTEGER,
    CONSTRAINT cpf_valido CHECK (LENGTH(cpf) = 11),
    CONSTRAINT funcionarios_funcao_unique UNIQUE(cpf, tipo)
);

CREATE TABLE farmacias (
    nome TEXT,
    farm_id SERIAL,
    bairro TEXT NOT NULL,
    cidade TEXT NOT NULL,
    estado ESTADO NOT NULL,
    gerente_cpf CHAR(11),
    gerente_func FUNC_TYPE,
    tipo CHAR(1) NOT NULL,
    CONSTRAINT farmacia_por_bairro_const UNIQUE(bairro),
    CONSTRAINT farmacia_tipo_valid CHECK (tipo = 'S' OR tipo = 'F'),
    CONSTRAINT farmacia_sede_unica EXCLUDE USING gist(tipo with=) WHERE (tipo = 'S'),
    CONSTRAINT farmacia_pk PRIMARY KEY(farm_id),
    CONSTRAINT gerente_cpf_fk FOREIGN KEY (gerente_cpf, gerente_func) REFERENCES funcionarios(cpf, tipo),
    CONSTRAINT gerente_func_valid CHECK (gerente_func = 'ADMINISTRADOR' OR gerente_func = 'FARMACEUTICO')
);


ALTER TABLE funcionarios ADD CONSTRAINT farmacia_pk FOREIGN KEY(farmacia_trabalho) REFERENCES farmacias(farm_id);

CREATE TABLE medicamento (
    nome TEXT NOT NULL,
    med_id SERIAL PRIMARY KEY,
    restrito BOOLEAN NOT NULL,
    preco NUMERIC NOT NULL,
    UNIQUE (med_id, restrito, preco)
);

CREATE TABLE clientes (
    nome TEXT,
    cpf CHAR(11),
    nasc DATE,
    CONSTRAINT client_pk PRIMARY KEY (cpf),
    CONSTRAINT valid_cpf_chk CHECK(LENGTH(cpf) = 11),
    CONSTRAINT client_idade_check CHECK ((extract(year from age(nasc))) >= 18)
);

CREATE TABLE vendas (
    venda_id SERIAL PRIMARY KEY,
    med_vendido INTEGER NOT NULL,
    med_restrito BOOLEAN NOT NULL,
    cli_id CHAR(11) NOT NULL,
    preco NUMERIC NOT NULL,
    vendedor_id CHAR(11) NOT NULL,
    vendedor_func FUNC_TYPE NOT NULL,
    
    CONSTRAINT venda_restrita CHECK(cli_id IS NOT NULL OR med_restrito = false),
    CONSTRAINT cli_id_notNUll FOREIGN KEY (cli_id) REFERENCES clientes(cpf),
    CONSTRAINT vendedor_fk FOREIGN KEY (vendedor_id, vendedor_func) REFERENCES funcionarios(cpf, tipo) ON DELETE RESTRICT,
    CONSTRAINT func_is_seller CHECK(vendedor_func = 'VENDEDOR'),
    CONSTRAINT valor_chk CHECK(preco >= 0)
);

ALTER TABLE vendas ADD CONSTRAINT prod_info FOREIGN KEY (med_vendido, med_restrito, preco) REFERENCES medicamento(med_id, restrito, preco) ON DELETE RESTRICT;

CREATE TABLE enderecos_cliente (
    end_id SERIAL PRIMARY KEY,
    cli_id CHAR(11) NOT NULL,
    endereco TEXT,
    estado ESTADO,
    tipo TIPO_ENDERECO NOT NULL,
    CONSTRAINT cliID_addressesss_fk FOREIGN KEY (cli_id) REFERENCES clientes(cpf)
);

CREATE TABLE entegas (
    entr_id SERIAL PRIMARY KEY,
    vend_id INTEGER REFERENCES vendas(venda_id),
    cli_id CHAR(11) REFERENCES clientes(cpf),
    add_id INTEGER NOT NULL,
    CONSTRAINT entrega_addressID_fk FOREIGN KEY(add_id) REFERENCES enderecos_cliente(end_id)
);