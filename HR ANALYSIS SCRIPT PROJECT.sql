-- HR ANALYTICS FOR A MULTINATIONAL COMPANY
-- Case Study Title: Workforce Structure, Compensation, and Organisational Insights Analysis
-- Analysis Objectives:   1.Understand workforce distribution
     -- 2.Analyze salary patterns and inequality
	-- 3.Evaluate managerial structure
	 -- 4.Identify high-cost and low-cost departments
	-- 5.Support HR decision-making with data 
  

-- DATA PREPROCESSING 
-- trim data(CATEGORICAL COLUMNS)
-- UPDATE countries
-- SET Country = TRIM(Country)

-- rename column  
ALTER TABLE countries
RENAME COLUMN Country TO country; 

-- change datatype
ALTER TABLE jobs
MODIFY COLUMN job_title TEXT;

-- DUPLICATES
WITH Duplicates AS  (
SELECT * , ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY employee_id) AS ROW_NUM
FROM employees)
SELECT *
FROM Duplicates
WHERE ROW_NUM >=1;
-- No duplicates found

UPDATE employees 
SET 
    phone_number = 'not stated'
WHERE
    phone_number IS NULL;
 
 
ALTER TABLE employees ADD COLUMN `role_level` VARCHAR(30);

UPDATE employees 
SET 
    role_level = 'Top Management'
WHERE
    manager_id IS NULL;

UPDATE employees 
SET 
    role_level = 'Staff'
WHERE
    manager_id IS NOT NULL;

UPDATE employees 
SET 
    manager_id = 200
WHERE
    manager_id IS NULL OR manager_id = '';

-- date format
SELECT 
    DATE_FORMAT(hire_date, '%Y-%m-%d')
FROM
    employees;

-- string to date
SELECT 
    STR_TO_DATE(hire_date, '%Y-%m-%d')
FROM
    employees;


UPDATE locations 
SET 
    state_province = 'Unknown'
WHERE
    state_province IS NULL;

UPDATE locations 
SET 
    postal_code = 'Unknown'
WHERE
    postal_code IS NULL;


UPDATE countries 
SET 
    country = 'Hong Kong'
WHERE
    country = 'HongKong';

UPDATE employees 
SET 
    salary = ROUND(salary, 0);

-- ANALYSIS
-- Employees with their department names and job titles
SELECT 
    e.first_name, e.last_name, d.department_name, j.job_title
FROM
    employees e
        JOIN
    departments d ON d.department_id = e.department_id
        JOIN
    jobs j ON j.job_id = e.job_id
ORDER BY e.first_name ASC;

-- top 5 highest-paid employees and their departments 
SELECT 
    e.first_name, e.last_name, e.salary, d.department_name
FROM
    employees e
        JOIN
    departments d ON d.department_id = e.department_id
ORDER BY e.salary DESC
LIMIT 5;

-- Average, minimum, and maximum salary per department
SELECT 
    d.department_name,
    AVG(e.salary) AS avg_salary,
    MIN(e.salary) AS min_salary,
    MAX(e.salary) AS max_salary
FROM
    employees e
        JOIN
    departments d ON d.department_id = e.department_id
GROUP BY d.department_name;

-- Which employees are earning below their job's minimum salary?
SELECT 
    e.first_name,
    e.last_name,
    e.salary AS actual_salary,
    j.min_salary AS minimum_salary
FROM
    employees e
        JOIN
    jobs j ON j.job_id = e.job_id
WHERE
    e.salary <= j.min_salary;
    
-- How many direct reports does each manager have?
SELECT   m.employee_id        AS manager_id,
         m.first_name         AS manager_first_name,
         m.last_name          AS manager_last_name,
         d.department_name,
         COUNT(e.employee_id) AS direct_reports
FROM     employees e
JOIN     employees   m ON e.manager_id    = m.employee_id
JOIN     departments d ON m.department_id = d.department_id
GROUP BY m.employee_id, m.first_name, m.last_name, d.department_name
ORDER BY direct_reports DESC;

-- Which employees were hired before 1995? Order them by hire date
SELECT 
    first_name, last_name, hire_date AS 'date of employment'
FROM
    employees
WHERE
    hire_date < '1995-01-01'
ORDER BY hire_date DESC;

-- Employee count per region
SELECT 
    r.region_name AS region, COUNT(e.employee_id)
FROM
    employees e
        JOIN
    departments d ON d.department_id = e.department_id
        JOIN
    locations l ON l.location_id = d.location_id
        JOIN
    countries c ON c.country_id = l.country_id
        JOIN
    regions r ON r.region_id = c.region_id
GROUP BY 1;


-- Employees with dependents and their dependent count
SELECT 
    e.first_name,
    e.last_name,
    COUNT(dep.dependent_id) AS dependent_count
FROM
    employees e
        JOIN
    dependents dep ON e.employee_id = dep.employee_id
GROUP BY 1 , 2;


-- Rank employees within each department by salary
SELECT 
    e.first_name,
    e.last_name,
    d.department_name,
    e.salary,
    RANK() OVER (
        PARTITION BY e.department_id
        ORDER BY e.salary DESC
    ) AS salary_rank
FROM employees e
JOIN departments d ON e.department_id = d.department_id
ORDER BY d.department_name, salary_rank;


--  Departments whose average salary exceeds $8,000 
with dept_avg AS (
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY 1
)
SELECT d.department_name, ROUND(da.avg_salary,2) AS avg_salary
FROM dept_avg da
JOIN departments d ON da.department_id = d.department_id
WHERE avg_salary >8000
ORDER BY 1 DESC;

-- method 2
SELECT 
    department_name, AVG(salary) AS avg_salary
FROM
    employees e
        JOIN
    departments d ON e.department_id = d.department_id
GROUP BY 1
HAVING avg_salary > 10000
ORDER BY 1;



-- Employees as Entry, Mid, or Senior by salary
SELECT 
    first_name,
    last_name,
    salary,
    CASE
        WHEN salary < 5000 THEN 'Entry Level'
        WHEN salary >= 17000 THEN 'Senior Level'
        ELSE 'Mid Level'
    END AS salary_band
FROM
    employees;

-- Employees who earn above the company average salary
SELECT 
    first_name, last_name, salary
FROM
    employees
WHERE
    salary > (SELECT 
            ROUND(AVG(salary), 2)
        FROM
            employees)
 
 
 
