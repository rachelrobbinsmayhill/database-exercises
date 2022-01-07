USE employees;


#2. 
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');
# 709 Rows returned



#3.
SELECT emp_no, first_name, last_name
FROM employees
WHERE first_name LIKE 'Irena' 
OR first_name LIKE 'Vidya' 
OR first_name LIKE 'Maya';
#709 Rows returned



#4. 
DESCRIBE employees;
SELECT emp_no, first_name, last_name, gender
FROM employees
WHERE gender = "M" AND 
(first_name LIKE 'Irena' 
OR first_name LIKE 'Vidya' 
OR first_name LIKE 'Maya');
#441 Rows returned



#5 STARTS with E
SELECT emp_no, last_name
FROM employees
WHERE last_name LIKE 'e%';
#7330 rows returned for last name starts with "e".



#6. STARTS OR ENDS with E
SELECT emp_no, last_name
FROM employees
WHERE last_name LIKE 'e%' 
  OR  last_name LIKE '%e';
#30,723 rows returned for last name starts OR ends with E


SELECT emp_no, last_name
FROM employees
WHERE last_name LIKE '%e' 
  AND NOT last_name LIKE 'e%';
#23393 rows returned for last name end with "e" but does not start wiht "e"




#7 Last name sTARTS AND ENDS with E
SELECT emp_no, last_name
FROM employees
WHERE last_name LIKE 'e%e';
# 899 Rows returned for Starts AND Ends with 'E'


# Last name ENDS in e
SELECT emp_no, last_name
FROM employees
WHERE last_name LIKE '%e';
# 24292 rows returned for employees whos last name ends in "e" regardless of whether they start with e



#8. 
DESCRIBE employees;
SELECT emp_no, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';
# 135214 rows returned for employees hired in the 90's



#9.
DESCRIBE employees;
SELECT emp_no, last_name, birth_date
FROM employees
WHERE birth_date LIKE '%12-25%';
#842 rows returned for Christmas birthdates.



#10.
DESCRIBE employees;
SELECT emp_no, hire_date, last_name, birth_date
FROM employees
WHERE birth_date LIKE '%12-25%'
	AND hire_date BETWEEN '1990-01-01' AND '1999-12-31';
#362 rows returned for born on Christmas and hired in 90's
 
 
 
#11. Q in last name 
SELECT emp_no, last_name
FROM employees
WHERE last_name LIKE '%q%';
# 1873 rows returned with q in the last name.
 


#12. Q in last name but not QU
SELECT last_name
FROM employees
WHERE last_name LIKE '%q%' 
   AND last_name NOT LIKE '%qu%';
 # 547 rows returned for last names with q but NOT qu. 
