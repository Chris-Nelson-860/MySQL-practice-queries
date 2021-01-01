--  === SELF CREATED ===

-- Return a table with the employee name, their department and their managers name.
SELECT CONCAT(e.first_name,' ',e.last_name) AS "Employee", departments.dept_name AS "Department", CONCAT(employees.first_name, ' ',employees.last_name) AS "Manager"
FROM employees e 
JOIN dept_emp ON e.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no
ORDER BY e.last_name ASC 
LIMIT 100;


-- Return employee first name, last name and department name
SELECT employees.first_name, employees.last_name, departments.dept_name 
FROM dept_emp 
JOIN employees ON dept_emp.emp_no = employees.emp_no 
JOIN departments ON dept_emp.dept_no = departments.dept_no
ORDER BY employees.last_name ASC 
LIMIT 100;


-- Return the names of the managers and the number of employees working under them
SELECT CONCAT(e.first_name,' ', e.last_name) AS "Name", COUNT(employees.emp_no) AS "Number of Subordinates"
FROM employees e
JOIN dept_manager ON e.emp_no = dept_manager.emp_no
JOIN dept_emp ON dept_manager.dept_no = dept_emp.dept_no
JOIN employees ON dept_emp.emp_no = employees.emp_no
GROUP BY dept_manager.emp_no
LIMIT 100; 


/* 

THESE QUERIES ARE FROM THE FOLLOWING LINK

https://www.w3resource.com/sql-exercises/employee-database-exercise/index.php#SQLEDITOR 

IT LOOKS LIKE THE QUESTIONS ARE NOT USING THE SAME EMPLOYEE DATABASE THAT I AM.  I AM APPLYING THESE QUERIES TO THE SAMPLE EMPLOYEE DATABASE THAT I HAVE ON MY MAC.  THE SCHEME IS ATTACHED IN THE FILES.

*/



-- Write a query in SQL to find the salaries of all employees.  Return employee number, name and salary

/*
    NOTE: At first this did not seem to difficult.  But there are date ranges in the salary.  This is returning duplicate employees.  I need to only return the latest salary. 

    My first though is to group the results by the date ranges, order them in desc and limit them to 1 each.
*/

--first attempt
SELECT e.emp_no AS "Employee Number", CONCAT(e.first_name,' ',e.last_name) AS "Name", s.salary AS "Salary"
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
ORDER BY e.last_name DESC
LIMIT 100;


--second attempt
SELECT e.emp_no AS "Employee Number", CONCAT(e.first_name,' ',e.last_name) AS "Name", (
    SELECT salary
    FROM salaries
    WHERE salaries.emp_no = e.emp_no
    GROUP BY from_date
    ORDER BY from_date DESC
    LIMIT 1
) AS "Salary"
FROM employees e
ORDER BY e.last_name DESC
LIMIT 100;