USE employees;

DESCRIBE employees;

-- Find all employees with first names Irena, Vidya, and Maya
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');

-- Find all employees whose last name starts with 'E'
SELECT *
FROM employees
WHERE last_name LIKE "E%";

-- Find all employees hired in the 90s
SELECT *
FROM employees
WHERE hire_date LIKE "199%";

-- Find all employees born on christmas (12/25)
SELECT *
FROM employees
WHERE birth_date LIKE '%-12-25';

-- Find all employees whose last name has a 'q' in it
SELECT *
FROM employees
WHERE last_name LIKE '%q%';

-- Updated Query to use OR instead of IN and check for only males
SELECT *
FROM employees
WHERE gender = 'M'
And (first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya');

-- Find all employees whose last name starts OR ends with 'e'
SELECT *
FROM employees
WHERE last_name LIKE 'E%'
OR last_name LIKE '%E';

-- Find all employees whose last name starts AND ends with 'e'
SELECT *
FROM employees
WHERE last_name LIKE 'E%'
AND last_name LIKE '%E';

-- Find all employees who were hired in the 90s and were born on christmas day
SELECT *
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%-12-25';

-- Find all employees with a 'q' in their name but not 'qu'
SELECT *
FROM employees
WHERE last_name LIKE '%q%'
AND NOT last_name LIKE '%qu%';