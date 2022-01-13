# join_exercises.sql


#. Use the join_example_db. Select all the records from both the users and roles tables.
SHOW Databases;
USE join_example_db;

SELECT * 
FROM users;
DESCRIBE users;

-- primary key: id
-- fields: id*, name, email, role_id


SELECT * 
FROM roles;
DESCRIBE roles;

-- priamry key: id
-- fields: id*, name
-- association: u.role_id r.id



#. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.


-- JOIN / INNER JOIN
SELECT * 
FROM users u
JOIN roles r
ON u.role_id = r.id;

-- LEFT JOIN
SELECT * 
FROM users u
LEFT JOIN roles r
ON u.role_id = r.id;

-- RIGHT JOIN 
SELECT * 
FROM users u
RIGHT JOIN roles r
ON u.role_id = r.id;


# Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.

SELECT * FROM users;
DESCRIBE users;

SELECT * FROM roles;
DESCRIBE roles;


SELECT r.id AS role_id, r.name AS role_name, u.role_id AS user_role_id, 
	COUNT(u.id)
FROM roles r
LEFT JOIN users u ON u.role_id = r.id
GROUP BY r.name, r.id; 


SELECT r.id, r.name, u.role_id, 
	COUNT(*)
FROM roles r
LEFT JOIN users u ON u.role_id = r.id
GROUP BY r.name, r.id; 

--  Remember COUNT(*) counts ALL rows - NULL AND NOT NULL
--  COUNT(specified column) counts only NOT NULL values


#1. Use the employees database.

SHOW Databases;
USE employees;
SELECT * FROM employees;

#2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

SELECT * FROM departments;
DESCRIBE departments;

-- Primary Key: dept_no
-- Association: dept_no

SELECT * FROM dept_manager;
DESCRIBE dept_manager;

-- CURRENT: ending in 9999
-- association: emp_no
-- Primary Key: emp_no and dept_no

SELECT * FROM employees LIMIT 50;

-- first_name, last_name, emp_no
-- association: emp_no



SELECT 
	CONCAT(e.first_name, ' ', e.last_name) AS "Deaprtment Manager",
	d.dept_name AS "Department Name"
FROM employees e
JOIN dept_manager m
	ON e.emp_no = m.emp_no	
JOIN departments d
	ON m.dept_no = d.dept_no
WHERE m.to_date = '9999-01-01';



#3. Find the name of all departments currently managed by women.
USE employees;
SELECT * FROM departments;
DESCRIBE departments;
-- primary key: dept_no
-- fields: dept_no, dept_name

SELECT * FROM dept_manager;
DESCRIBE dept_manager;
-- primary key: emp_no, dept_no
-- fields:  emp_no, dept_no, from_date, to_date
-- association: dept_no

SELECT * FROM employees;
DESCRIBE employees;
-- primary key: emp_no
-- fields: emp_no, birth_date, first_name, last_name, gender, hire_date
-- association: emp_no



SELECT 
	d.dept_name AS "Department Name", 
   CONCAT(e.first_name, ' ', e.last_name) AS "Manger Name"
FROM employees e
JOIN dept_manager m
	ON e.emp_no = m.emp_no	
JOIN departments d
	ON m.dept_no = d.dept_no
WHERE m.to_date = '9999-01-01' and e.gender = "f";



#4. Find the current titles of employees currently working in the Customer Service department.

SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM titles;


SELECT t.title AS 'Title', COUNT(de.emp_no) AS 'Count'
FROM titles t
JOIN dept_emp de
	ON t.emp_no = de.emp_no	
JOIN departments d
	ON de.dept_no = d.dept_no
WHERE de.to_date = '9999-01-01' AND t.to_date = '9999-01-01' AND d.dept_no = 'd009'
GROUP BY t.title;
 


# 5. Find the current salary of all current managers.

SELECT * FROM salaries LIMIT 10;
SELECT * FROM employees LIMIT 10;
SELECT * FROM dept_manager LIMIT 10;
SELECT * FROM departments;


SELECT 
	d.dept_name AS 'Department Name',
	CONCAT(e.first_name, ' ', e.last_name) AS 'Name',
	s.salary AS 'Salary'			
FROM departments d
JOIN dept_manager dm
ON d.dept_no = dm.dept_no
	JOIN employees e
	ON dm.emp_no = e.emp_no
		JOIN salaries s
		ON e.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01' AND dm.to_date = '9999-01-01'
ORDER BY d.dept_name;


# 6. Find the number of current employees in each department.

	
SELECT * FROM departments;
SELECT * FROM dept_emp;


SELECT d.dept_no, d.dept_name, COUNT(de.emp_no) AS num_employees
FROM departments d
JOIN dept_emp de
ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01'
GROUP BY dept_no
ORDER BY dept_no;


#7. Which department has the highest average salary? Hint: Use current not historic information.

SELECT * FROM salaries;
SELECT * FROm dept_emp;


SELECT d.dept_name AS dept_name, AVG(s.salary) AS average_salary
FROM departments d
JOIN dept_emp de
	ON d.dept_no = de.dept_no
JOIN salaries s
	ON de.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01' AND de.to_date = '9999-01-01'
GROUP BY dept_name 
ORDER BY average_salary DESC limit 1;



#8. Who is the highest paid employee in the Marketing department?

SELECT * FROM departments;

SELECT e.first_name AS first_name, e.last_name AS last_name
FROM departments d
JOIN dept_emp de
	ON d.dept_no = de.dept_no
JOIN employees e
	ON de.emp_no = e.emp_no
JOIN salaries s
	ON e.emp_no = s.emp_no
WHERE de.to_date = '9999-01-01' AND s.to_date = '9999-01-01' AND d.dept_no = 'd001' 
ORDER BY s.salary DESC limit 1;


#9. Which current department manager has the highest salary?

SELECT 
	e.first_name AS first_name, 
	e.last_name AS last_name, 
	s.salary 	AS salary, 
	d.dept_name AS dept_name
FROM departments d
	JOIN dept_manager dm
		ON d.dept_no = dm.dept_no
	JOIN employees e
		ON dm.emp_no = e.emp_no
	JOIN salaries s
		ON e.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01' AND dm.to_date = '9999-01-01'
ORDER BY s.salary DESC LIMIT 1;


# 10. Determine the average salary for each department. Use all salary information and round your results.

SELECT * FROM salaries;

SELECT d.dept_name AS dept_name, 
		ROUND(AVG(s.salary)) AS average_salary
FROM departments d
	JOIN dept_emp de
		ON d.dept_no = de.dept_no
	JOIN employees e
		ON de.emp_no = e.emp_no
	JOIN salaries s
		ON e.emp_no = s.emp_no
GROUP BY dept_name
ORDER BY average_salary DESC;


#11. Bonus Find the names of all current employees, their department name, and their current manager's name.


SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM dept_emp;
DESCRIBE dept_emp;


SELECT 
	CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name', 		 
	d.dept_name AS 'Department Name', 
	CONCAT(em.first_name, ' ', em.last_name) AS 'Manager Name' 
FROM departments d
JOIN dept_emp de
	ON d.dept_no = de.dept_no	
JOIN employees e
	ON de.emp_no = e.emp_no
JOIN dept_manager dm
	ON d.dept_no = dm.dept_no
JOIN employees em
	ON dm.emp_no = em.emp_no
	
WHERE de.to_date = '9999-01-01' AND dm.to_date = '9999-01-01'
ORDER BY CONCAT(e.first_name, ' ', e.last_name);







SELECT e.first_name AS first_name, e.last_name AS last_name
FROM departments d
JOIN dept_emp de
	ON d.dept_no = de.dept_no
JOIN employees e
	ON de.emp_no = e.emp_no
JOIN salaries s
	ON e.emp_no = s.emp_no
WHERE de.to_date = '9999-01-01' AND s.to_date = '9999-01-01' AND d.dept_no = 'd001' 
ORDER BY s.salary DESC limit 1;

#12. Bonus Who is the highest paid employee within each department.

SHOW Databases;
USE employees;
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM salaries;


SELECT d.dept_name AS department, 
		  CONCAT(e.first_name, ' ', e.last_name) AS employee_name, 
		  s.salary AS salary

FROM departments d
JOIN dept_emp de
	ON d.dept_no = de.dept_no
JOIN employees e
	ON de.emp_no = e.emp_no
JOIN salaries s
	ON e.emp_no = s.emp_no
WHERE de.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
	AND (d.dept_name, s.salary) IN
			(SELECT
				d.dept_name, MAX(s.salary)
				FROM departments d
 				  JOIN dept_emp de
						ON d.dept_no = de.dept_no
				  JOIN employees e
						ON de.emp_no = e.emp_no
				  JOIN salaries s
						ON e.emp_no = s.emp_no
           WHERE de.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
           GROUP BY d.dept_name
				)
ORDER BY salary DESC;


