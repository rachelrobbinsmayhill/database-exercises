# temporary_tables.sql


# CREATE a FILE named temporary_tables.sql TO DO your WORK FOR this exercise.

# 1. USING the example FROM the lesson, CREATE a TEMPORARY TABLE called employees_with_departments that CONTAINS 

-- first_name, last_name, AND dept_name FOR employees currently WITH that department. 

-- Be absolutely sure TO CREATE this TABLE ON your own database. IF you see "Access denied for user ...", it means that the QUERY was attempting TO WRITE a NEW TABLE TO a DATABASE that you can only read.

SELECT DATABASE();
USE innis_1656;
SHOW TABLES;


CREATE TEMPORARY TABLE employees_with_departments AS 
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING (emp_no)
JOIN employees.departments USING (dept_no)
LIMIT 100;

SELECT * FROM employees_with_departments;



# 1a. ADD a COLUMN named full_name TO this table. It should be a VARCHAR whose length IS the sum of the lengths of the FIRST NAME AND LAST NAME COLUMNS

DESCRIBE employees_with_departments;
# first_name	varchar(14)	NO		NULL	NULL
# last_name	varchar(16)	NO		NULL	NULL
# SUM is 30

ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);



# 1b. UPDATE the TABLE so that FULL NAME COLUMN CONTAINS the correct DATA

UPDATE employees_with_departments 
SET full_name = CONCAT(first_name, ' ', last_name);
SELECT * FROM employees_with_departments;



# 1c. Remove the first_name AND last_name COLUMNS FROM the table.

ALTER TABLE employees_with_departments DROP COLUMN first_name, DROP COLUMN last_name;

SELECT * FROM employees_with_departments;


# 1d. What IS another way you could have ended up WITH this same TABLE?

CREATE TEMPORARY TABLE employees_with_departments_2 AS 
SELECT emp_no, CONCAT(first_name, ' ', last_name) AS full_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING (emp_no)
JOIN employees.departments USING (dept_no)
LIMIT 100;


SELECT * FROM employees_with_departments_2;





# 2. CREATE a TEMPORARY TABLE based ON the payment TABLE FROM the sakila database.

CREATE TEMPORARY TABLE payments_from_sakila AS
(
SELECT *
FROM sakila.payment
LIMIT 100
);

-- 2a. WRITE the SQL necessary TO transform the amount COLUMN such that it IS stored AS an INTEGER representing the number of cents of the payment. FOR example, 1.99 should become 199.



DESCRIBE payments_from_sakila;

ALTER TABLE payments_from_sakila 
	MODIFY amount DECIMAL (7,2); 

UPDATE payments_from_sakila 
	SET amount = (amount * 100); 

ALTER TABLE payments_from_sakila 
	MODIFY amount INT; 

SELECT * FROM payments_from_sakila;



# 3. Find OUT how the current average pay IN EACH department compares TO the overall, historical average pay. 

CREATE TEMPORARY TABLE comparison_department_salaries AS
	(SELECT dept_name, AVG(s.salary) AS average_salary
FROM employees.departments d
	JOIN employees.dept_emp de USING (dept_no)
	JOIN employees.salaries s USING (emp_no)
WHERE s.to_date = '9999-01-01' AND de.to_date = '9999-01-01'
GROUP BY dept_name 
ORDER BY average_salary LIMIT 100);

SELECT * FROM comparison_department_salaries;

-- 3a.IN order TO make the comparison easier, you should USE the Z-score FOR salaries. (z-score is number of SD above or below the mean zscore = value - mean / SD )

SELECT dept_name, average_salary,
		(average_salary - (SELECT AVG(salary) FROM employees.salaries))
		/
		(SELECT stddev(salary) FROM employees.salaries) AS zscore
		
FROM comparison_department_salaries;


# 3b. IN terms of salary, what IS the best department RIGHT now TO WORK FOR? 
-- Sales with a z-score of ~1.48


# 3c.The worst?
-- Human Resources with a z-score of ~0.00657# 




# BELOW was used to build my query for question # 3. 
# Overall historical average salary
SELECT AVG(salary)
FROM salaries;


# Average pay in each department
SELECT d.dept_name AS dept_name, AVG(s.salary) AS average_salary
FROM departments d
JOIN dept_emp de
	ON d.dept_no = de.dept_no
JOIN salaries s
	ON de.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01' AND de.to_date = '9999-01-01'
GROUP BY dept_name 
ORDER BY average_salary;






