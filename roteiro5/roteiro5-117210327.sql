--Q1
SELECT COUNT(sex) FROM employee WHERE sex = 'F';

--Q2
SELECT AVG(salary) FROM employee WHERE address LIKE '%, TX' AND sex = 'M';

--Q3
SELECT m.ssn, COUNT(e.superssn) 
FROM (employee AS m JOIN employee AS e ON (m.ssn = e.superssn) 
GROUP BY e.superssn 
ORDER BY COUNT(e.superssn) ASC, m.ssn ASC; 


--SELECT m.ssn, COUNT(e.superssn) 
--FROM employee AS m, employee AS e 
--WHERE (e.superssn = m.ssn AND e.superssn IS NOT NULL) OR (e.superssn IS NULL AND m IS NOT NULL)
--GROUP BY m.ssn, e.superssn 
--ORDER BY COUNT(e.superssn) ASC, m.ssn ASC; 
