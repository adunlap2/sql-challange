-- Create a titles table 
CREATE TABLE titles (
    title_id VARCHAR(30),
    title varchar(30),
    PRIMARY KEY (title_id)
);

-- create a department table
CREATE TABLE departments (
    dept_no VARCHAR(30),
    dept_name VARCHAR(30),
    PRIMARY KEY (dept_no)
);

-- create a department employees table
CREATE TABLE dept_emp (
    emp_no INT,
    dept_no VARCHAR(30),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

-- create department managers table
CREATE TABLE dept_manager (
    dept_no VARCHAR(30),
    emp_no INT,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (dept_no, emp_no)
);

-- create employees table
CREATE TABLE employees (
    emp_no INT,
    emp_title_id VARCHAR(30),
    birth_date DATE,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    sex VARCHAR(30),
    hire_date DATE,
    FOREIGN KEY (emp_title_id) REFERENCES titles (title_id),
    PRIMARY KEY (emp_no)
);

-- create salaries table
CREATE TABLE salaries (
    emp_no INT,
    salary INT,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
);

--1.)List the employee number, last name, first name, sex, and salary of each employee.

SELECT e.emp_no as employee_number, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e
LEFT JOIN salaries as s
ON e.emp_no = s.emp_no
ORDER BY employee_number;

--2.)List the first name, last name, and hire date for the employees who were hired in 1986.

Select first_name, last_name, hire_date
from employees
where hire_date Between '1986-01-01'And '1986-12-31';

--3.)List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM departments d 
JOIN dept_manager dm ON (d.dept_no = dm.dept_no)
JOIN employees e ON (dm.emp_no = e.emp_no);


--4.)List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de ON (e.emp_no = de.emp_no)
JOIN departments d ON (de.dept_no = d.dept_no);

--5.)List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees 
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';


--6.)List each employee in the Sales department, including their employee number, last name, and first name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e 
JOIN dept_emp dep ON (e.emp_no = dep.emp_no)
JOIN departments d ON (dep.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales';


--7.)List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e 
JOIN dept_emp dep ON (e.emp_no = dep.emp_no)
JOIN departments d ON (dep.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales' 
OR d.dept_name = 'Development'


--8.)List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT count(last_name) as frequency, last_name
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;
