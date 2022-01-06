SHOW DATABASES;
USE `chipotle`;
SELECT database ();
SHOW DATABASES;
USE `numbers`;
SELECT database ();

SHOW DATABASES;
USE `employees`;
SHOW TABLES;
DESCRIBE `employees`;
SHOW TABLES;
DESCRIBE `departments`;
DESCRIBE `dept_emp`;
DESCRIBE `dept_manager`;
DESCRIBE `employees`;
DESCRIBE `salaries`;
DESCRIBE `titles`;
DESCRIBE `current_dept_emp`;
DESCRIBE `dept_emp_latest_date`
DESCRIBE `dept_manager`;
SHOW CREATE TABLE `dept_manager`;




# 4. List all the tables: There are 8 tables.

# 5. What kind of data types are present on this table? int, date (x2), varchar (x2), and enum

# 6. Which table(s) do you think contain a numeric type column? dept_emp, dept_manager, employees, salaries, titles, current_dept_emp, dept_emp_latest_date  

# 7. Which table(s) do you think contain a string type column? departments, dept_emp,dept_manager,employees, titles, current_dept_emp     

# 8. Which table(s) do you think contain a date type column? dept_emp, dept_manager, employees, salaries, titles, current_dept_emp, dept_emp_latest_date    

# 9. What is the relationship between the employees and the departments tables?  Currently there does not display a commonality. It may be helpful to add a deprtment column to the employee table. 

# 10.Show the SQL that created the dept_manager table: CREATE TABLE `dept_manager` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1
-- 
