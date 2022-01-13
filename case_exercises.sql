# case_exercises.sql

# USE CASE statements OR IF() FUNCTION TO explore information IN the employees DATABASE
SHOW DATABASES;
USE employees;

#1. WRITE a QUERY that RETURNS ALL employees, their department number, their START DATE, their END DATE, AND a NEW COLUMN 'is_current_employee' that IS a 1 IF the employee IS still WITH the company AND 0 IF not.


SELECT * FROM dept_emp;

SELECT 
	emp_no, dept_no, from_date AS start_date, to_date AS end_date,
		CASE to_date
		WHEN to_date > CURDATE() THEN 1
		ELSE 0
	END AS is_current_employee
FROM dept_emp; 

# Alternate Example IF()

SELECT
	emp_no, dept_no, from_date, to_date,
	IF(to_date > CURDATE(), TRUE, FALSE) AS is_current_employee
FROM dept_emp;




#2. WRITE a QUERY that RETURNS ALL employee NAMES (previous AND current), AND a NEW COLUMN 'alpha_group' that RETURNS 'A-H', 'I-Q', OR 'R-Z' depending ON the FIRST letter of their LAST name.

SELECT 
	first_name, last_name,
	CASE
		WHEN REGEXP_LIKE (last_name,'^[A-H].*') THEN 'A-H'
		WHEN REGEXP_LIKE (last_name,'^[I-Q].*') THEN 'I-Q'
		WHEN REGEXP_LIKE (last_name,'^[R-Z].*') THEN 'R-Z' 
		END AS alpha_group
FROM employees;


-- ALTERNATIVE #1
SELECT first_name, last_name, 
	CASE
	WHEN LEFT(last_name ,1) BETWEEN 'A' AND 'H' THEN 'A-H'
	WHEN LEFT(last_name ,1) BETWEEN 'I' AND 'Q' THEN 'I-Q'
	WHEN LEFT(last_name ,1) BETWEEN 'R' AND 'Z' THEN 'R-Z'
		END AS alpha_group
FROM employees;

	
-- ALTERNATIVE #2
SELECT first_name, last_name,
	LEFT(last_name, 1) AS first_letter_of_last_name,
	CASE
	WHEN LEFT(last_name, 1) <= 'H' THEN 'A-H'
	WHEN LEFT(last_name, 1) <= 'Q' THEN 'I-Q'
	WHEN LEFT(last_name, 1) <= 'Z' THEN 'R-Z'
	
END AS alpha_group
FROM employees;


-- ALTERNATIVE #3 w/ substring
SELECT 
	LEFT(last_name, 1) = substr(last_name, 1,1)
	
FROM employees;




#3. How many employees (current OR previous) were born IN EACH decade?


SELECT * FROM employees;
SELECT COUNT(*),
	CASE 
		WHEN birth_date BETWEEN '1950-01-01' AND '1959-12-31' THEN '50s'
ELSE '60s'
END AS decade_born
FROM employees
GROUP BY decade_born;

/*
182886	 50s
117138	 60s
*/

# ALternate

SELECT * FROM employees;
SELECT COUNT(*),
	CASE 
		WHEN birth_date LIKE '195%' THEN '50s'
ELSE '60s'
END AS decade_born
FROM employees
GROUP BY decade_born;


# Alternative

SELECT 
	CONCAT(SUBSTR(birth_date, 1, 3), '0') AS decade,
	COUNT(*)
FROM employees
GROUP BY decade;


#4. What IS the current average salary FOR EACH of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?


SELECT
	CASE 
		WHEN dept_name IN ('research', 'development') THEN 'R&D'
		WHEN dept_name IN ('sales', 'marketing') THEN 'Sales and Marketing'
		WHEN dept_name IN ('production', 'quality managment') THEN 'Prod & QM'
		ELSE dept_name
	END AS dept_group,
	ROUND(AVG(s.salary)) AS average_salary
FROM departments d
JOIN dept_emp de
	ON d.dept_no = de.dept_no
JOIN salaries s
		ON de.emp_no = s.emp_no
WHERE s.to_date > NOW() AND de.to_date > NOW()
GROUP BY dept_group;



# This is where I was with my thinking before going over it as a class. Partially complete.

SELECT d.dept_name AS dept_name, cd
		ROUND(AVG(s.salary)) AS average_salary
FROM departments d
	JOIN dept_emp de
		ON d.dept_no = de.dept_no
	JOIN employees e
		ON de.emp_no = e.emp_no
	JOIN salaries s
		ON e.emp_no = s.emp_no
	JOIN combined_departments cd
		ON d.dept_name = cd.dept_name
		CASE 
					WHEN dept_name IN ('research', 'development') THEN 'R&D'
					WHEN dept_name IN ('sales', 'marketing') THEN 'Sales and Marketing'
					WHEN dept_name IN ('production', 'quality managment') THEN 'Prod & QM'
					ELSE dept_name
					END AS dept_group
FROM departments;

