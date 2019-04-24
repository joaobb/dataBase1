CREATE TYPE MUSIC_STYLE AS ENUM('R', 'P', 'E', 'S', 'A', 'C');

CREATE TABLE usuario (
    nome CHAR(15) PRIMARY KEY,
    data_nasc DATE NOT NULL
);

CREATE TABLE musica (
    titulo TEXT NOT NULL,
    estilo MUSIC_STYLE NOT NULL
);

CREATE TABLE avaliacoes (
    nota SMALLINT NOT NULL,
    data_aval DATE,
    usuario CHAR(15),
    music TEXT,  
    CONSTRAINT grade_interval CHECK(nota >= 0 AND nota <= 5),
    CONSTRAINT user_fk FOREIGN KEY(usuario) REFERENCES usuario(nome) ON DELETE RESTRICT,
    CONSTRAINT music_fk FOREIGN KEY(music) REFERENCES musica(titulo) ON DELETE RESTRICT
);

CREATE TABLE perfil_usuario (
    id INTEGER PRIMARY KEY,
    descr_perfil TEXT NOT NULL,
    cadastra_usuario BOOLEAN NOT NULL,
    cadastra_música BOOLEAN NOT NULL,
    faz_avaliacao BOOLEAN NOT NULL
);
