#. order_by_exercises.sql
SHOW DATABASES;
USE employees;


#2. 
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;
# FIRST ROW: Irena	Reutenauer  
# LAST ROW: Vidya Simmen



#3.
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name LIKE 'Irena' 
OR first_name LIKE 'Vidya' 
OR first_name LIKE 'Maya'
ORDER BY first_name, last_name;
# FIRST ROW: Irena	Action  
#LAST ROW: Vidya Zweizig


#4.
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;
# FIRST ROW: Irena Action  
# LAST ROW: Maya Zyda

#5.
SELECT emp_no, first_name, last_name
FROM employees
WHERE last_name LIKE 'e%e'
 ORDER BY emp_no;
# 899 Employees returned.
# FIRST ROW: 10021	Ramzi	Erde
# LAST ROW: 499648	Tadahiro	Erde

#6. 
SELECT emp_no, first_name, last_name, hire_date
FROM employees
WHERE last_name LIKE 'e%e'
 ORDER BY hire_date DESC;
# 899 Employees returned.
# NEWEST EMPLOYEE: Teiji	Eldridge 
# OLDEST EMPLOYEE: Sergi	Erde

#7.
DESCRIBE employees;
SELECT emp_no, first_name, last_name, birth_date, hire_date
FROM employees
WHERE birth_date LIKE '%12-25%'
	AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	ORDER BY birth_date ASC, hire_date DESC;
# 362 Employees returned. 
# OLDEST EMPLOEE HIRED LAST: 33936	Khun	Bernini	1952-12-25	1999-08-31
# YOUNGEST EMPLOYEE HIRED FIRST: 412745	Douadi	Pettis	1964-12-25	1990-05-04 
