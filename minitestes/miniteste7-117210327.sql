SELECT e.fname, e.lname, e.salary
FROM employee as e
WHERE (NOT EXISTS (
    SELECT essn
    FROM works_on as w
    WHERE essn = e.ssn
    ))
    
    AND 
    (salary NOT IN (
        SELECT MAX(salary)
        FROM employee))
    
    AND 
    (salary NOT IN (
        SELECT MIN(salary)
        FROM employee));
