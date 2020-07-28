SELECT emp_no
		, dept_no
		, hire_date AS start_date
		, to_date AS end_date
		, CASE WHEN de.to_date > CURDATE() THEN 1 ELSE 0 END AS is_current_emp
FROM dept_emp de
JOIN employees AS e USING(emp_no);

-- Write a query that returns all employee names, and a new column 'alpha-group' that returns 'A-H', 'I-Q' , or 'R-Z' depending on the first letter of their last name.
SELECT first_name, 
	   last_name,
	   CASE WHEN SUBSTR(last_name, 1, 1) < 'I' THEN 'A-H'
	   		WHEN SUBSTR(last_name, 1, 1) < 'R' THEN 'I-Q'
	   		ELSE 'R-Z' END AS alpha_group
FROM employees
ORDER BY alpha_group;

SELECT first_name, last_name
	, CASE WHEN last_name REGEXP '^[A-H]' THEN 'A-H'
		WHEN last_name REGEXP '^[I-Q]' THEN 'I-Q'
		WHEN last_name REGEXP '^[R-Z]' THEN 'R-Z'
		ELSE null
		END AS alpha_group
FROM employees
ORDER BY alpha_group;

-- How many employees were born in each decade
SELECT COUNT(birth_date) num_employees,
		CASE 
		WHEN YEAR(birth_date) BETWEEN 1950 AND 1959 THEN '1950s'
		WHEN YEAR(birth_date) BETWEEN 1960 AND 1969 THEN '1960s'
		ELSE 'Catch' END AS decades
FROM employees
GROUP BY decades;
