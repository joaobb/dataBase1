--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.14
-- Dumped by pg_dump version 9.5.14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_superior_cpf_fkey;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT func_cpf_fkey_set_null;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT tarefas_pk;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
DROP TABLE public.tarefas;
DROP TABLE public.funcionario;
SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: joaopdbb
--

CREATE TABLE public.funcionario (
    cpf character(11) NOT NULL,
    data_nasc date,
    nome text,
    funcao text,
    nivel character(1),
    superior_cpf character(11),
    CONSTRAINT cpf_size CHECK ((length(cpf) = 11)),
    CONSTRAINT has_sup CHECK ((((funcao = 'LIMPEZA'::text) AND (superior_cpf IS NOT NULL)) OR (funcao = 'SUP_LIMPEZA'::text))),
    CONSTRAINT invalid_nivel CHECK (((nivel = 'J'::bpchar) OR (nivel = 'P'::bpchar) OR (nivel = 'S'::bpchar)))
);


ALTER TABLE public.funcionario OWNER TO joaopdbb;

--
-- Name: tarefas; Type: TABLE; Schema: public; Owner: joaopdbb
--

CREATE TABLE public.tarefas (
    id bigint NOT NULL,
    descricao text NOT NULL,
    func_resp_cpf character(11) NOT NULL,
    prioridade smallint NOT NULL,
    status character(1) NOT NULL,
    CONSTRAINT cpf_validity CHECK ((length(func_resp_cpf) = 11)),
    CONSTRAINT id_negativo CHECK ((id > 0)),
    CONSTRAINT priority_limit CHECK (((prioridade >= 0) OR (prioridade <= 5))),
    CONSTRAINT status_validity CHECK ((((status = 'E'::bpchar) AND (func_resp_cpf IS NOT NULL)) OR ((status = 'P'::bpchar) OR (status = 'C'::bpchar))))
);


ALTER TABLE public.tarefas OWNER TO joaopdbb;

--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: joaopdbb
--

INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('38957494064', '2000-09-18', 'Samuel', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('92724485167', '1956-12-02', 'Igor', 'SUP_LIMPEZA', 'J', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('92248101412', '1969-12-18', 'Paulo', 'SUP_LIMPEZA', 'J', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('58392438031', '1975-11-29', 'Bianca', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('48224677798', '1979-04-23', 'Yasmin', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('59740984233', '1984-10-13', 'Alice', 'LIMPEZA', 'S', '92248101412');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('20225191315', '2006-04-13', 'Sarah', 'LIMPEZA', 'S', '92724485167');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('24021674430', '1968-02-15', 'Matheus', 'LIMPEZA', 'P', '92724485167');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('58392434843', '1975-04-10', 'Jorge', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('81378200801', '1949-11-10', 'Campelo', 'LIMPEZA', 'S', '58392438031');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432111', '1999-05-15', 'Ghanor', 'LIMPEZA', 'J', '38957494064');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432122', '1996-02-29', 'Otori', 'LIMPEZA', 'S', '92248101412');


--
-- Data for Name: tarefas; Type: TABLE DATA; Schema: public; Owner: joaopdbb
--

INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483646, 'limpar chão do corredor central', '98765432111', 0, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483657, 'limpar as lagrimas da sala de prova', '81378200801', 5, 'E');


--
-- Name: funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: joaopdbb
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: tarefas_pk; Type: CONSTRAINT; Schema: public; Owner: joaopdbb
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT tarefas_pk PRIMARY KEY (id, func_resp_cpf);


--
-- Name: func_cpf_fkey_set_null; Type: FK CONSTRAINT; Schema: public; Owner: joaopdbb
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT func_cpf_fkey_set_null FOREIGN KEY (func_resp_cpf) REFERENCES public.funcionario(cpf) ON DELETE SET NULL;


--
-- Name: funcionario_superior_cpf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: joaopdbb
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_superior_cpf_fkey FOREIGN KEY (superior_cpf) REFERENCES public.funcionario(cpf);


--
-- PostgreSQL database dump complete
--

