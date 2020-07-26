USE employees;

-- Find all employees with the same hire_date as employee 101010 using a sub-query
SELECT e.*
FROM ( 
		SELECT *
		FROM employees WHERE emp_no = 101010
	) AS e10
LEFT JOIN employees AS e
	   ON e.hire_date = e10.hire_date;

-- Find all the titles held by all employees with the first name Aamod
SELECT CONCAT(first_name, ' ', last_name) AS 'Full Name', a_list.title
FROM (
	SELECT first_name, last_name, e.emp_no, title
	FROM employees AS e
	JOIN titles AS t
  	  ON e.emp_no = t.emp_no AND first_name = 'Aamod'
  	 ) AS a_list;

-- How many people in the employees table are no longer working at the company	
SELECT CONCAT(first_name, ' ', last_name) AS "Full Name", emp_no
FROM employees
WHERE emp_no NOT IN (
    SELECT emp_no
    FROM dept_emp AS de
    WHERE to_date > CURDATE()
);

-- Find all the current department managers that are female
SELECT Full_Name
FROM (SELECT emp_no, CONCAT(first_name, ' ', last_name) AS Full_Name
		FROM employees
		WHERE gender = 'F') AS F
JOIN dept_manager = de
  ON de.emp_no = F.emp_no AND to_date > CURDATE();
  
--	Find all the employees that currently have a higher than average salary
SELECT CONCAT(first_name, ' ', last_name) AS 'Full Name', salary
FROM employees AS e
JOIN salaries AS s
  ON e.emp_no = s.emp_no AND to_date > CURDATE()
WHERE salary > (SELECT AVG(salary) FROM salaries);

-- How many current salaries are within 1 standard deviation of the highest salary
SELECT COUNT(*) AS "Salaries Within STD of Max"
	, (SELECT (
		SELECT COUNT(*)
		FROM employees AS e
		JOIN salaries AS s
  		ON e.emp_no = s.emp_no AND to_date > CURDATE()
		WHERE salary > (SELECT MAX(salary) - STD(salary) FROM salaries)
			  ) / COUNT(*) * 100
FROM employees AS e
JOIN salaries AS s
  ON e.emp_no = s.emp_no AND to_date > CURDATE()
  	   ) AS "Percent of Total Salaries"
FROM employees AS e
JOIN salaries AS s
  ON e.emp_no = s.emp_no AND to_date > CURDATE()
WHERE salary > (SELECT MAX(salary) - STD(salary) FROM salaries);
  
  
-- Find all the department names that currently have female managers
SELECT dept_name
FROM departments AS d
JOIN (SELECT CONCAT(first_name, ' ', last_name) AS full_name, dept_no
		FROM employees AS e
		JOIN dept_manager AS dm
  		  ON e.emp_no = dm.emp_no AND to_date > CURDATE() AND gender = 'F') AS mgrs
  ON d.dept_no = mgrs.dept_no;
  
-- Find the first and last name of the employee with the highest salary
SELECT CONCAT(first_name, ' ', last_name) AS "Full Name"
FROM employees AS e
JOIN salaries AS s
  ON e.emp_no = s.emp_no AND to_date > CURDATE()
WHERE salary = (SELECT MAX(salary)
				FROM salaries
				WHERE to_date > CURDATE());

-- Find the department name that the employee with the highest salary works in
SELECT dept_name
FROM dept_emp AS de
JOIN salaries AS s
  ON de.emp_no = s.emp_no AND s.to_date > CURDATE()
JOIN departments AS d
  ON de.dept_no = d.dept_no
WHERE salary = (SELECT MAX(salary)
				FROM salaries
				WHERE to_date > CURDATE());