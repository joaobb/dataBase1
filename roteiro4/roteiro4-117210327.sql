--Aluno: Joao Pedro de Barros Barbosa
--Matricula: 117210327

--questao1
SELECT * FROM department;
--questao2
SELECT * FROM dependent;
--questao3
SELECT * FROM dept_locations;
--questao4
SELECT * FROM employee;
--questao5
SELECT * FROM project;
--questao6
SELECT * FROM works_on;

--questao7
SELECT fname, lname FROM employee WHERE sex = 'M';

--questao8
SELECT fname FROM employee WHERE sex = 'M' AND superssn IS NULL;

--questao9
SELECT e.fname, s.fname FROM employee AS e, employee AS s WHERE e.superssn = s.ssn;

--questao10
SELECT e.fname FROM employee AS e, employee AS s WHERE e.superssn = s.ssn and s.fname = 'Franklin';

--questao11
SELECT d.dname, l.dlocation FROM department as d, dept_locations as l WHERE d.dnumber = l.dnumber;

--questao12
SELECT d.dname FROM department as d, dept_locations as l WHERE d.dnumber = l.dnumber and l.dlocation LIKE 'S%';

--questao13
SELECT (e.fname, e.lname) as employee_name, (d.dependent_name) FROM employee as e, dependent as d WHERE d.essn = e.ssn;

--questao14
SELECT (fname || ' ' || minit || '. ' || lname) as full_name, salary FROM employee WHERE salary > 50000;

--questao15
SELECT p.pname, d.dname FROM project AS p, department AS d WHERE p.dnum = d.dnumber;

--questao16
SELECT p.pname, m.fname FROM project AS p, employee AS m, department as d WHERE p.dnum = d.dnumber AND m.ssn = d.mgrssn AND p.pnumber > 30;

--questao17
SELECT p.pname, e.fname FROM project AS p, employee AS e, works_on AS w WHERE w.pno = p.pnumber AND w.essn = e.ssn;

--questao18
SELECT e.fname, d.dependent_name, d.relationship FROM dependent AS d, employee as e, works_on as w WHERE w.essn = e.ssn AND d.essn = e.ssn AND w.pno = 91;