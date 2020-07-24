USE join_example_db;

SELECT *
FROM users
JOIN roles
  ON users.role_id = roles.id;

SELECT *
FROM users
LEFT JOIN roles
  ON users.role_id = roles.id;
  
SELECT *
FROM users
RIGHT JOIN roles
  ON users.role_id = roles.id;
  
SELECT r.name, COUNT(*)
FROM roles AS r
JOIN users
  ON r.id = users.role_id
GROUP BY r.name;

USE employees;

-- Show each department's name and the name of the current manager for that department
SELECT d.dept_name AS "Department Name", CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager'
FROM employees AS e
JOIN dept_manager AS dm 
  ON e.emp_no = dm.emp_no AND dm.to_date > curdate()
JOIN departments AS d
  ON dm.dept_no = d.dept_no
ORDER BY d.dept_name;

-- Find the name of all departments currently managed by women
SELECT d.dept_name AS "Department Name", CONCAT(e.first_name, ' ', e.last_name) AS "Department Manager"
FROM employees AS e
JOIN dept_manager AS dm
  ON e.emp_no = dm.emp_no AND dm.to_date > curdate()
JOIN departments AS d
  ON dm.dept_no = d.dept_no
WHERE e.gender = 'F'
ORDER BY d.dept_name;

-- Find the current titles of employees working in the customer service department.
SELECT t.title AS 'Title', COUNT(de.emp_no) AS 'Count'
FROM titles AS t
JOIN dept_emp AS de
  ON t.emp_no = de.emp_no
JOIN departments AS d
  ON de.dept_no = d.dept_no AND d.dept_no = 'd009'
WHERE t.to_date > curdate()
  AND de.to_date > curdate()
GROUP BY t.title;

-- Find the current salary of all current managers
SELECT d.dept_name AS "Department Name", CONCAT(e.first_name, ' ', e.last_name) AS Fullname, s.salary AS Salary
FROM employees AS e
JOIN dept_manager as dm
  ON e.emp_no = dm.emp_no AND dm.to_date > CURDATE()
JOIN departments AS d
  ON dm.dept_no = d.dept_no
JOIN salaries AS s 
  ON e.emp_no = s.emp_no AND s.to_date > CURDATE()
GROUP BY d.dept_name, e.emp_no, s.salary;

-- Find the number of employees in each department
SELECT d.dept_no, d.dept_name, COUNT(*) AS num_employees
FROM departments AS d
JOIN dept_emp AS de
  ON d.dept_no = de.dept_no AND de.to_date > CURDATE()
GROUP BY d.dept_no;


;-- Which department has the highest average salary
SELECT d.dept_name, ROUND(AVG(salary)) as average_salary
FROM departments AS d
JOIN dept_emp AS de
  ON d.dept_no = de.dept_no AND de.to_date > CURDATE()
JOIN salaries AS s
  ON de.emp_no = s.emp_no AND s.to_date > CURDATE()
GROUP BY d.dept_name
ORDER BY average_salary DESC
LIMIT 1;

-- Who is the highest paid in the marketing department
SELECT e.first_name, e.last_name
FROM employees AS e
JOIN dept_emp AS de
  ON e.emp_no = de.emp_no AND de.dept_no = 'd001'
JOIN salaries AS s
  ON e.emp_no = s.emp_no AND s.to_date > CURDATE()
ORDER BY salary DESC
LIMIT 1;

-- Which current department manager has the highest salary
SELECT e.first_name, e.last_name, s.salary, d.dept_name
FROM employees AS e
JOIN dept_manager AS dm
  ON e.emp_no = dm.emp_no AND dm.to_date > CURDATE()
JOIN departments AS d
  ON d.dept_no = dm.dept_no
JOIN salaries AS s
  ON e.emp_no = s.emp_no AND s.to_date > CURDATE()
ORDER BY salary DESC
LIMIT 1;

-- Find the names of all current employees, their department name, and their current manager's name
SELECT CONCAT(e.first_name, ' ', e.last_name) AS "Employee Name", d.dept_name AS "Department Name", mn.Mgr_Name AS "Manager Name"
FROM employees AS e
JOIN dept_emp AS de
  ON de.emp_no = e.emp_no AND de.to_date > CURDATE()
JOIN departments AS d
  ON d.dept_no = de.dept_no
JOIN ( -- Subquery to get department managers' names
		SELECT dm.dept_no, CONCAT(e.first_name, ' ', e.last_name) Mgr_Name
	FROM departments AS d
	JOIN dept_manager AS dm
  	  ON dm.dept_no = d.dept_no AND dm.to_date > CURDATE()
	JOIN employees AS e
  	  ON dm.emp_no = e.emp_no
  	 ) AS mn
  ON mn.dept_no = d.dept_no;

-- Find the highest paid employee in each department
SELECT  d.dept_name AS "Department Name", CONCAT(first_name, ' ', last_name) AS full_name, d_max.sal AS "Salary"
FROM employees AS e
JOIN dept_emp AS de
  ON e.emp_no = de.emp_no AND de.to_date > CURDATE()
JOIN salaries AS s
  ON e.emp_no = s.emp_no AND s.to_date > CURDATE()
JOIN departments AS d
  ON de.dept_no = d.dept_no
JOIN (
		SELECT MAX(salary) AS sal, d.dept_no
			FROM departments AS d
			JOIN dept_emp AS de
  			  ON d.dept_no = de.dept_no AND de.to_date > CURDATE()
			JOIN employees AS e
  			  ON de.emp_no = e.emp_no
			JOIN salaries AS s
  			  ON e.emp_no = s.emp_no AND s.to_date > CURDATE()
			GROUP BY d.dept_no
	) AS d_max
  ON de.dept_no = d_max.dept_no
WHERE salary = d_max.sal
ORDER BY d.dept_name;

