#. functions_exercises.sql.

#1. Copy the order by exercise and save it as functions_exercises.sql.
SHOW DATABASES;
USE employees;



#2.Write a query to to find all employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name.

USE employees;
SELECT CONCAT(first_name, " ", last_name) AS full_name
FROM employees
WHERE last_name LIKE 'e%e';


#3. Convert the names produced in your last query to all uppercase.

USE employees;
SELECT UPPER(
	CONCAT(first_name, " ", last_name)
			   ) AS full_name
FROM employees
WHERE last_name LIKE 'e%e';


#4. Find all employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),

DESCRIBE employees;
SELECT first_name, last_name, hire_date, birth_date, DATEDIFF(CURDATE(),hire_date) AS working_days
FROM employees
WHERE birth_date LIKE '%12-25%'
	AND hire_date LIKE '199%';
	

#ALTERNATE: 	
SELECT first_name, last_name, DATEDIFF(CURDATE(), hire_date) / 365 AS years_with_firm
FROM employees
WHERE hire_date LIKE '199%' AND birth_date LIKE '%-12-25';
	
	
	
#5 Find the smallest and largest current salary from the salaries table.

# SMALLEST: 38_623
# LARGEST: 40_000

SELECT emp_no, MIN(salary)
FROM salaries
GROUP BY emp_no
ORDER BY MIN(salary)
LIMIT 1;


SELECT emp_no, MAX(salary)
FROM salaries
GROUP BY emp_no
ORDER BY MAX(salary)
LIMIT 1;


#ALTERNATE:

SELECT MAX(salary), MIN(salary) FROM salaries;


#6. Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:


SHOW DATABASES;
USE employees;
DESCRIBE employees;
SELECT LOWER(CONCAT(SUBSTR(first_name,1,1), SUBSTR(last_name,1,4), "_", SUBSTR(birth_date,6,2), SUBSTR(birth_date,3,1))) AS user_name
FROM employees
LIMIT 10;



# Alternate:

SELECT * FROM employees LIMIT 2;

SELECT SUBSTR(first_name, 1, 1) FROM employees LIMIT 2;


-- creating a username:
-- all lowercase -> LOWER()
-- first letter of first name -> SUBSTR(first_name, 1, 1)
-- first four of last name -> SUBSTR(last_name, 1, 4)
-- '_' -> CONCAT() --. CONCAT(SUBSTR(first_name, 1, 1), '_', SUBSTR(last_name, 1, 4), SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2))
-- month of birth -> SUBSTR(birth_date, 6, 2)
-- last two digits of birth year -> SUBSTR(birth_date, 3, 2)



SELECT
LOWER(
	CONCAT(
			SUBSTR(first_name, 1, 1), 
			SUBSTR(last_name, 1, 4), 
			'_',
			SUBSTR(birth_date, 6, 2),
			SUBSTR(birth_date, 3, 2)
		)
	
) AS user_name
FROM employees
LIMIT 10;









