-- Recreate the employees_with_departments table from the lesson
CREATE TEMPORARY TABLE employees_with_departments AS
SELECT e.emp_no, e.first_name, e.last_name, employees.dept_emp.dept_no, employees.departments.dept_name
FROM employees.employees AS e
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;

-- Add a column named full_name to this table, it should be a VARCHAR whose length is the sum of the lengths of the first and last name columns
ALTER TABLE employees_with_departments ADD full_name VARCHAR(31);
-- Update the table so that full name column contains the correct data
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

-- Remove the first and last names from t he table
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

-- Another way to end up with the same table
CREATE TEMPORARY TABLE employees_with_departments AS
SELECT e.emp_no, CONCAT(e.first_name, ' ', e.last_name) AS full_name, employees.dept_emp.dept_no, employees.departments.dept_name
FROM employees.employees AS e
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;

-- Create a temporary table based on the payment table from the sakila database, transform the amount column such taht it is stored as an integer
-- representing the number of cents of the payment for example 1.99 should become 199
CREATE TEMPORARY TABLE temp_payment AS
SELECT *
FROM sakila.payment AS p;

ALTER TABLE temp_payment ADD new_amount INT(64);

UPDATE temp_payment
SET new_amount = amount * 100;

ALTER TABLE temp_payment DROP COLUMN amount;

ALTER TABLE temp_payment ADD amount INT(64);

UPDATE temp_payment
SET amount = new_amount;

ALTER TABLE temp_payment DROP COLUMN new_amount;

-- Find out how the average pay in each department compares to the overall average pay, use the z-score for salaries comparison
CREATE TABLE emps AS
SELECT
e.*,
s.salary,
d.dept_name AS department,
d.dept_no
FROM employees.employees AS e
JOIN employees.salaries AS s USING(emp_no)
JOIN employees.dept_emp AS de USING(emp_no)
JOIN employees.departments AS d USING(dept_no)
WHERE s.to_date > CURDATE()
AND de.to_date > CURDATE();

ALTER TABLE emps ADD mean_salary FLOAT;
ALTER TABLE emps ADD sd_salary FLOAT;
ALTER TABLE emps ADD z_salary FLOAT;

CREATE TEMPORARY TABLE salary_aggregates AS
SELECT AVG(salary) AS mean,
STD(salary) AS sd
FROM emps;

UPDATE emps SET mean_salary = (SELECT mean FROM salary_aggregates);
UPDATE emps SET sd_salary = (SELECT sd FROM salary_aggregates);
UPDATE emps SET z_salary = (salary - mean_salary) / sd_salary;

SELECT department, avg(z_salary) as z_salary
FROM emps
GROUP BY department;