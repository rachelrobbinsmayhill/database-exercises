# GROUP BY EXERCISES

# 1. Create a new file named group_by_exercises.sql



# 2. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.


USE employees;
DESCRIBE titles;
SELECT DISTINCT title FROM titles;
# 7 distinct titles




#3. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
SELECT last_name FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY last_name;

/* 
Erde
Eldridge
Etalle
Erie
Erbe
*/




#4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.

SELECT first_name, last_name FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY last_name, first_name;
#846 employees




#5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.

SELECT last_name
FROM employees
WHERE last_name LIKE '%q%' 
   AND last_name NOT LIKE '%qu%'  
GROUP BY last_name;

/* 
Chleq
Lindqvist
Qiwen
*/





#6. Add a COUNT() to your results (the query above) to find the number of employees with the same last name.

SELECT last_name, COUNT(*)
FROM employees
WHERE last_name LIKE '%q%' 
   AND last_name NOT LIKE '%qu%'  
GROUP BY last_name;

/*
189	Chleq
190	Lindqvist
168	Qiwen
*/





#7. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

DESCRIBE employees;
SELECT first_name, gender, COUNT(*)
FROM employees
WHERE first_name LIKE 'Irena' 
OR first_name LIKE 'Vidya' 
OR first_name LIKE 'Maya'
GROUP BY first_name, gender
ORDER BY first_name;


/*
Irena	M	144
Irena	F	97
Maya	M	146
Maya	F	90
Vidya	M	151
Vidya	F	81
*/



#Alternate: 
DESCRIBE employees;
SELECT first_name, gender, COUNT(*)
FROM employees
WHERE first_name IN( 'Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender
ORDER BY first_name; 


#8. Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?


SELECT LOWER(CONCAT(SUBSTR(first_name,1,1), SUBSTR(last_name,1,4), "_", SUBSTR(birth_date,6,2), SUBSTR(birth_date,3,2))) AS user_name,
	COUNT(*) AS duplicate_usernames 

FROM employees
GROUP BY user_name;
HAVING Count(user_name) >= 2;

# Total Usernames: 300_024
# Unique Usernames: 285_872
# Duplicate Usernames: 13_251



# Alternate: 
SELECT LOWER(CONCAT(SUBSTR(first_name,1,1), SUBSTR(last_name,1,4), "_", SUBSTR(birth_date,6,2), SUBSTR(birth_date,3,2))) AS user_name,
	COUNT(CONCAT(SUBSTR(first_name,1,1), SUBSTR(last_name,1,4),"_", SUBSTR(birth_date,6,2), SUBSTR(birth_date,3,2))) 

FROM employees
GROUP BY user_name
HAVING Count(user_name) >= 2;

#Alternate #2:

SELECT LOWER(CONCAT(SUBSTR(first_name,1,1), SUBSTR(last_name,1,4), "_", SUBSTR(birth_date,6,2), SUBSTR(birth_date,3,2))) AS user_name,
	COUNT(*) AS duplicate_usernames 

FROM employees
GROUP BY user_name
HAVING duplicate_usernames >1
ORDER BY duplicate_usernames DESC;


#3 Alternate: 
SELECT t.count(*),
SUM(t.duplicate_usernames)
FROM
(SELECT LOWER(CONCAT(SUBSTR(first_name,1,1), SUBSTR(last_name,1,4), "_", SUBSTR(birth_date,6,2), SUBSTR(birth_date,3,2))) AS user_name,
	COUNT(*) AS duplicate_usernames 

FROM employees
GROUP BY user_name
HAVING duplicate_usernames > 1
ORDER BY duplicate_usernames DESC) as t;


#9. More practice with aggregate functions:

-- a. Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.

SELECT emp_no, AVG(salary)
	  AS average_salary
FROM salaries
GROUP BY emp_no;


-- b. Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.

DESCRIBE dept_emp;
SELECT * FROM dept_emp;
SELECT dept_no, COUNT(dept_no) 
FROM dept_emp
	WHERE to_date = '9999-01-01'
GROUP BY dept_no;

/*
d001	14842
d002	12437
d003	12898
d004	53304
d005	61386
d006	14546
d007	37701
d008	15441
d009	17569
*/



#Alternate:

DESCRIBE dept_emp;
SELECT * FROM dept_emp;
SELECT dept_no, COUNT(*) 
FROM dept_emp
	WHERE to_date = '9999-01-01'
GROUP BY dept_no;


#Alternate #2: 
DESCRIBE dept_emp;
SELECT * FROM dept_emp;
SELECT dept_no, COUNT(*) 
FROM dept_emp
WHERE to_date > NOW()
GROUP BY dept_no;

-- c. Determine how many different salaries each employee has had. This includes both historic and current.

SELECT * FROM salaries;
SELECT emp_no, COUNT(*)
FROM salaries
GROUP BY emp_no;


#Alternate: 
SELECT * FROM salaries;
SELECT emp_no, COUNT(emp_no)
FROM salaries
GROUP BY emp_no;




-- d. Find the maximum salary for each employee.

SELECT emp_no, MAX(salary)
FROM salaries
GROUP BY emp_no;



-- e. Find the minimum salary for each employee.

SELECT emp_no, MIN(salary) 
FROM salaries
GROUP BY emp_no;

-- f. Find the standard deviation of salaries for each employee.

SELECT emp_no, STDDEV(salary)
FROM salaries
GROUP BY emp_no;


-- g. Now find the max salary for each employee where that max salary is greater than $150,000.

SELECT emp_no, MAX(salary)
FROM salaries
	WHERE salary > '150000'
GROUP BY emp_no;
# 15 rows returned

# Alternate: 
SELECT emp_no, MAX(salary) AS max_sal
FROM salaries
GROUP BY emp_no
HAVING max_sal > 150000;

-- h. Find the average salary for each employee where that average salary is between $80k and $90k.


SELECT emp_no, AVG(salary) AS average_salary	  
FROM salaries
GROUP BY emp_no
HAVING AVG(salary) BETWEEN 80000 AND 90000;

# Alternate: 
SELECT emp_no, AVG(salary) AS avg_sal
FROM salaries
GROUP BY emp_no
HAVING avg_sal > 80000 AND avg_sal < 90000
ORDER BY avg_sal DESC;

