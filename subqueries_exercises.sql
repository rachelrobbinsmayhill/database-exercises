# Sub-queries

# Practice
SHOW DATABASES;
USE employees;

-- SCALER SUBQUERIES

# All CURRENT employees who's salary is greater than the overall average salary for CURRENt employees.

SELECT emp_no, salary
FROM salaries
WHERE salary > (SELECT AVG(salary) FROM salaries WHERE to_date > CURDATE())
AND to_date > CURDATE();

# ALL the CURRENT employee numbers w/ salary figures if they make more than twice the current average salary.

SELECT emp_no, salary
FROM salaries
WHERE salary > 2 * (SELECT AVG(salary) FROM salaries WHERE to_date > CURDATE())
AND to_date > CURDATE();


-- COLUMN SUBQUERIES - return a single column

# Find all department manager names and date of births.
SELECT first_name, last_name, birth_date
FROM employees WHERE emp_no IN(
	SELECT emp_no 
	FROM dept_manager
)
LIMIT 10;

-- ROW SUBQUERIES - return a single row

# 
SELECT first_name, last_name, birth_date
FROM employees
WHERE emp_no = (
	SELECT emp_no
	FROM employees
	WHERE emp_no = 101010
);

-- Alternate 

SELECT first_name, last_name, birth_date
FROM employees
WHERE emp_no = 101010;



#. Create a file named subqueries_exercises.sql and craft queries to return the results for the following criteria



#1. Find all the current employees with the same hire date as employee 101010 using a sub-query.

SELECT * FROM employees;
SELECT * FROM dept_emp;

SELECT emp_no, hire_date AS hire_date_same_as_emp_101010
FROM employees
WHERE emp_no IN(
	SELECT emp_no 
	FROM dept_emp
WHERE to_date > CURDATE()) 
	AND hire_date = (
		SELECT hire_date 
		FROM employees 
WHERE emp_no = 101010);  



#2. Find all the titles ever held by all current employees with the first name Aamod.
USE employees;
SELECT title
FROM titles
WHERE emp_no IN(
	SELECT emp_no 
	FROM dept_emp 
	WHERE to_date > CURDATE()
	)
AND emp_no IN(
  	SELECT emp_no  
  	FROM employees 
  	WHERE first_name = 'Aamod'
  	)
GROUP BY title;

/*
Isamu	Legleitner
Karsten	Sigstam
Leon	DasSarma
Hilary	Kambil
*/


#3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

SELECT * FROM dept_emp;

SELECT COUNT(emp_no)
FROM employees
WHERE emp_no NOT IN(
	SELECT emp_no 
	FROM dept_emp 
	WHERE to_date>CURDATE()
);
#59_900 no longer work for the company.




#4. Find all the current department managers that are female. List their names in a comment in your code.

SELECT * FROM dept_manager;

SELECT first_name, last_name 
FROM employees
WHERE emp_no IN(
		SELECT emp_no 
		FROM dept_manager 
		WHERE to_date > CURDATE()
	   )
AND gender = 'f';

/* 
Isamu	Legleitner
Karsten	Sigstam
Leon	DasSarma
Hilary	Kambil
*/


#5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.

SELECT * FROM employees;
SELECT * FROM salaries;

SELECT AVG(salary)
FROM salaries;
# 63_810.7448 Company's overall, historical AVG salary. 


SELECT CONCAT(e.first_name, ' ', e.last_name) AS 'employee',
		 s.salary AS 'salary'
	FROM employees AS e
	JOIN salaries AS s
		ON e.emp_no = s.emp_no
WHERE s.to_date > CURDATE()
	AND s.salary > (
					 SELECT AVG(salary)
					 	FROM salaries
					 )
ORDER BY s.salary;
     
     
     
     
#6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
-- Hint Number 1 You will likely use a combination of different kinds of subqueries.
-- Hint Number 2 Consider that the following code will produce the z score for current salaries.

SELECT * FROM salaries;

SELECT salary
FROM salaries
WHERE to_date > CURDATE()
ORDER BY salary DESC;
# Current Salaries 240_124, MAX salary 158_220


SELECT COUNT(salary) AS quantity_of_salaries
FROM salaries
WHERE to_date > CURDATE();
# Current Salaries COUNT 240_124

SELECT MAX(salary) 
FROM salaries
WHERE to_date > CURDATE();
# Current MAX salary 158_220


SELECT MAX(salary) - STDDEV(salary) 
FROM salaries
WHERE to_date > CURDATE();
# 1 Standard Devation from Highest 140910.04066365326


  

# Gives the count for all salaries that are below the standard deviation
SELECT COUNT(salary) AS salaries_within_one_SD
FROM salaries
WHERE salary >=(
	SELECT MAX(salary) - STDDEV(salary) 
	FROM salaries
	WHERE to_date > CURDATE() AND to_date > CURDATE())
	AND to_date > CURDATE();
-- 83 salaries	


# Provides percentage of ALL historical salaries within 1 SD of the highest salary
SELECT COUNT(salary)/(
	SELECT COUNT(*)
	FROM salaries
	)
* 100 AS salaries_within_one_SD
FROM salaries
WHERE salary >=(
	SELECT MAX(salary) - STDDEV(salary) 
	FROM salaries
	WHERE to_date > CURDATE() AND to_date > CURDATE())
	AND to_date > CURDATE();

-- .29%





# BONUS 1 - Find all the department names that currently have female managers.


# BONUS 2 - Find the first and last name of the employee with the highest salary.


# BONUS 3 - Find the department name that the employee with the highest salary works in.
