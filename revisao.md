# Definição
- Coleção de dados RELACIONADOS.
- Dados são fatos que posuem significado implícito.

# Modelo Relacional
- Baseado no conceito de CONJUNTOS
- Em uma tabela, cada linha corresponde a uma entidade real (tupla), enquanto as colunas são os atributos.
- Cada valor dentro de cada tupla deve pertencer do domínio do atributo de sua coluna correspondente.
- Chave: atributo(s) que identificam unicamente cada tupla da tabela. Esta pode ser artificial, ou seja, criada apenas para o banco de dados.

* Esquema/descrição: R(A1, A2, ..., An)
	* Sendo R o nome da relação e An os atributos desta.
	* Cada atributo pertence a um domínio, dom(An)

- Esquema de relações: Conjunto de relações de um mesmo bando de dados.
	* S = {R1, R2, ..., Rn} + IC (IC = integrity constraints)

- Uma relação é um conjunto de tuplas

- Estado da relação (povoamento)
	* Representado por r(R) c dom(A1) X dom(A2) X ... X dom(An)

- Ordenação:
  * Tuplas não são consideradas ordenadas
  * Os atributos de uma tupla são considerados ordenados.
  * Exite também a representação "AUTO DESCRITIVA", similar ao modelo JSON.
    * t = {<name, "John">, <SSN, 123456789>}	

- Estado/snapshot
  * Backup de um banco de dados util para auditorias e verificaçoes. Armazena as informações do banco com um determinado momento, e as modificações que foram feitas até o banco atual.

- Constraints
  * 1. Implícitas: Impostas pela natureza do modelo.
  * 2. Explícitas: Impostas pelo DBA em SQL.
  * 3. Semânticas: Impostas pelo DBA em nível de aplicação, por ser muito complexas. 

- Restrições de integridade
  * Restrições de Chave:
    * Super-key: Conjunto de atributos que identificam uma tupla.
    * Key: Super-key em que a retirada de qualquer atributo, resulta em super-chaves iguais para tuplas diferentes.
    * - Super-key mínima
  * Caso hava várias chaves possíveis, a escolha para a primary key é arbitrária.

  * Restrição de Entidade:
    * Os atributos da PK naõ podem ser NULL

  * Integridade Referencial:
    * Referenciaçõa de duas relações.

* Restrições em operações de atualização:
  * Bloquar operação: RESTRICT
  * Atualização em massa: CASCADE ou SET NULL
