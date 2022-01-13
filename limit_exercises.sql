
#1. 
# limit_exercises.sql

SHOW TABLES;

SELECT DISTINCT title
FROM titles;


#2.
SHOW DATABASES;
USE employees;
SELECT DISTINCT last_name 
FROM employees 
ORDER BY last_name DESC
LIMIT 10;

/*
Zykh
Zyda
Zwicker
Zweizig
Zumaque
Zultner
Zucker
Zuberek
Zschoche
Zongker
*/



#3.
DESCRIBE employees;
SELECT first_name, last_name, hire_date
FROM employees
WHERE birth_date LIKE '%12-25%'
	AND hire_date LIKE '199%'
	ORDER BY hire_date ASC
LIMIT 5;

/* 
Alselm Cappello	1990-01-01
Utz	Mandell	1990-01-03
Bouchung Schreiter	1990-01-04
Baocai Kushner	1990-01-05
Pette Stroustrup	1990-01-10
*/




#4. DESCRIBE employees;
SELECT first_name, last_name, hire_date
FROM employees
WHERE birth_date LIKE '%12-25%'
	AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	ORDER BY hire_date ASC
LIMIT 5 OFFSET 45;

/* 
Pranay	Narwekar	1990-07-18
Marjo	Farrow	1990-07-18
Ennio	Karcich	1990-08-05
Dines	Lubachevsky	1990-08-06
Ipke	Fontan	1990-08-06
*/

# The relationship betweem offset, limit, and page number can be identified using a formula
 # Offset = (limit * desired page number) - limit 
 # OR (Page-1) * Limit = Offset
 
 #added