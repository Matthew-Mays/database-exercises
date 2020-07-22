USE employees;

-- use distinct to find the unique titles in the titles table
SELECT DISTINCT title
FROM titles;

-- Update query to find just the unique last names that start and end with 'E' using group by
SELECT last_name
FROM employees
WHERE last_name LIKE 'E%'
AND last_name LIKE '%E'
GROUP BY last_name;

-- Update previous query to find unique combinatiosn of first and last name where last name starts and ends with 'E'
SELECT last_name, first_name
FROM employees
WHERE last_name LIKE 'E%'
AND last_name LIKE '%E'
GROUP BY last_name, first_name;

-- find the unique last names with a 'q' but not a 'qu'
SELECT last_name
FROM employees
WHERE last_name LIKE '%q%'
AND NOT last_name LIKE '%qu%'
GROUP BY last_name;

-- add a count() to your results and use order by to make it easier to find employees whose unusuall name is shared with others
SELECT last_name, COUNT(last_name) AS 'Last Name Count'
FROM employees
WHERE last_name LIKE '%q%'
AND NOT last_name LIKE '%qu%'
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;

-- update query for 'Irena', 'Vidya', and 'Maya' Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names
SELECT COUNT(*), gender
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY gender;

-- this shows that there are many duplicate usernames
SELECT CONCAT(LOWER(SUBSTR(first_name, 1, 1)), LOWER(SUBSTR(last_name, 1, 4)), '_', SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2)) AS 'Usernames', COUNT(*) AS 'Duplicates'
FROM employees
GROUP BY CONCAT(LOWER(SUBSTR(first_name, 1, 1)), LOWER(SUBSTR(last_name, 1, 4)), '_', SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2))
ORDER BY COUNT('Duplicates') DESC;