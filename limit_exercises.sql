USE employees;

DESCRIBE employees;

-- List the first 10 distinct last name sorted in descending order
SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10;

-- Update query for employees born on christmas and hired in the 90s to limit to the first five
SELECT *
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%-12-25'
ORDER BY birth_date, hire_date DESC
LIMIT 5;

-- Update it to show the 10th page of last query
SELECT *
FROM employees
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%-12-25'
ORDER BY birth_date, hire_date DESC
LIMIT 5 OFFSET 45;

-- The Relationship between LIMIT(L), OFFSET(O), and PAGE NUMBER(P) is P = O / Like + 1 