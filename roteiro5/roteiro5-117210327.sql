--Q1
SELECT COUNT(*) 
FROM employee 
WHERE sex = 'F';

--Q2
SELECT AVG(salary) 
FROM employee 
WHERE address LIKE '%TX'AND sex = 'M';

--Q3
SELECT S.ssn AS ssn_supervisor, COUNT(*) AS qtd_supervisionados 
FROM employee AS S RIGHT OUTER JOIN employee AS E ON S.ssn = E.superssn 
GROUP BY S.ssn 
ORDER BY qtd_supervisionados ASC;

--Q4
SELECT S.fname AS nome_supervisor, COUNT(*) AS qtd_supervisionados 
FROM employee AS S JOIN employee AS E ON E.superssn = S.ssn 
GROUP BY S.fname 
ORDER BY qtd_supervisionados ASC;

--Q5
SELECT S.fname AS nome_supervisor, COUNT(*) AS qtd_supervisionados 
FROM employee AS S RIGHT OUTER JOIN employee AS E ON S.ssn = E.superssn 
GROUP BY S.fname 
ORDER BY qtd_supervisionados ASC;

--Q6
SELECT MIN(qtd) AS qtd 
FROM (
    SELECT p.pnumber, COUNT(*) AS qtd 
    FROM project AS p, works_on AS W 
    WHERE p.pnumber = w.pno 
    GROUP BY p.pnumber) 
AS fun;

--Q7
SELECT pno AS num_projeto, qtd AS qtd_func
FROM (
    (SELECT pno, COUNT(*)
    FROM works_on
    GROUP BY pno) AS pnc
    
    JOIN
    
    (SELECT MIN(count) AS qtd
    FROM (
        SELECT COUNT(*)
        FROM works_on
        GROUP BY pno
    ) t ) AS minumum

    ON pnc.count = minumum.qtd
);

--Q8
SELECT w.pno AS num_projeto, AVG(e.salary) AS media_sal 
FROM works_on AS w, employee AS e 
WHERE e.ssn = w.essn GROUP BY w.pno;

--Q9
SELECT p.pnumber AS num_projeto, p.pname AS proj_nome, AVG(e.salary) AS media_sal 
FROM works_on AS w, employee AS e, project AS p 
WHERE e.ssn = w.essn AND w.pno = p.pnumber 
GROUP BY p.pnumber;

--Q10
SELECT e.fname, e.salary 
FROM employee as e 
WHERE e.salary > ALL (
    SELECT a.salary 
    FROM works_on AS w, employee AS a 
    WHERE a.ssn = w.essn AND w.pno = 92);

--Q11
SELECT e.ssn, COUNT(w.essn) AS qtd_proj 
FROM employee AS e LEFT OUTER JOIN works_on AS w ON e.ssn = w.essn 
GROUP BY e.ssn 
ORDER BY qtd_proj ASC;

--Q12
SELECT w.pno AS num_projeto, COUNT(*) AS qtd_fun 
FROM employee AS e LEFT OUTER JOIN works_on AS w ON e.ssn = w.essn 
GROUP BY w.pno HAVING COUNT(*) < 5;

--Q13
SELECT e.fname 
FROM employee AS e 
WHERE EXISTS(
    SELECT * 
    FROM dependent 
    WHERE e.ssn = essn) 
    AND 
    EXISTS (
        SELECT * 
        FROM dept_locations AS l, department AS d 
        WHERE e.dno = d.dnumber AND d.dnumber = l.dnumber AND l.dlocation = 'Sugarland');

--Q14
SELECT d.dname 
FROM department AS d 
WHERE NOT EXISTS (
    SELECT * 
    FROM project AS p 
    WHERE d.dnumber = p.dnum);

--Q15
SELECT e.fname, e.lname 
FROM employee AS e 
WHERE NOT EXISTS(
    (SELECT w.pno 
    FROM works_on AS w 
    WHERE w.essn = '123456789') 
    EXCEPT(
        SELECT pno 
        FROM works_on 
        WHERE e.ssn = essn AND NOT(e.ssn = '123456789')
        )
    );

