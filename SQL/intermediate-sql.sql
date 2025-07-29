-- Joins

SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

SELECT *
FROM employee_demographics
JOIN employee_salary
	ON employee_demographics.employee_id = employee_salary.employee_id;
    
SELECT *
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;

SELECT dem.employee_id, age, occupation
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
    

-- Outer Joins

SELECT *
FROM employee_demographics dem
LEFT JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;

SELECT *
FROM employee_demographics dem
RIGHT JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;
    

-- Self Join

SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1 = emp2.employee_id;

SELECT emp1.employee_id emp_santa,
	emp1.first_name first_name_santa,
    emp1.last_name last_name_santa,
    emp2.employee_id emp_name,
    emp2.first_name first_name_emp,
    emp2.last_name last_name_emp
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1 = emp2.employee_id;
    
    
-- Joining multiple tables together

SELECT *
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
JOIN parks_departments pd
	ON sal.dept_id = pd.department_id;

SELECT dem.employee_id, dem.first_name, occupation, salary, department_name
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
JOIN parks_departments pd
	ON sal.dept_id = pd.department_id;


-- Unions

SELECT first_name, last_name
FROM employee_demographics
UNION
SELECT first_name, last_name
FROM employee_salary;

SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary;

SELECT first_name, last_name, 'Old Man' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION
SELECT first_name, last_name, 'Old Lady' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'Highly Paid Employee' AS Label
FROM employee_salary
WHERE salary > 70000
ORDER BY first_name, last_name;


-- String Functions

-- Length

SELECT first_name, LENGTH(first_name)
FROM employee_demographics
ORDER BY 2;

-- Upper and Lower

SELECT UPPER(first_name)
FROM employee_demographics;

SELECT LOWER(first_name)
FROM employee_demographics;

-- Trims

SELECT TRIM('     strawberry      ');

SELECT LTRIM('     strawberry      ');

SELECT RTRIM('     strawberry      ');


-- Left and Right

SELECT first_name, LEFT(first_name, 4)
FROM employee_demographics;

SELECT first_name, RIGHT(first_name, 4)
FROM employee_demographics;

-- Substrings

SELECT first_name,
	LEFT(first_name, 4),
	RIGHT(first_name, 4),
    SUBSTRING(first_name,3,2),
    SUBSTRING(birth_date,6,2) birth_month
FROM employee_demographics;


-- Replace

SELECT first_name, REPLACE(first_name, 'a', 'z')
FROM employee_demographics;


-- Locate

SELECT LOCATE('y', 'Melyssa');

SELECT LOCATE('An', first_name)
FROM employee_demographics;


-- Concatenation

SELECT first_name, last_name,
	CONCAT(first_name, ' ', last_name)
FROM employee_demographics;


-- Case Statements

SELECT first_name, last_name,
CASE
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 AND 50 THEN 'Old'
    WHEN age >= 50 THEN "On Death's Door"
END AS Age_Bracket
FROM employee_demographics;

-- Pay Increase and Bonus
-- < 50000 = 5% 
-- > 50000 = 7% 
-- Finance = 10% bonus

SELECT CONCAT(first_name, ' ', last_name) AS full_name, salary,
CASE
	WHEN salary < 50000 THEN salary + (salary * 0.05)
    WHEN salary > 50000 THEN salary + (salary * 0.07)
END AS new_salary,
CASE
	WHEN dept_id = 6 THEN salary * .10
END AS bonus
FROM employee_salary;


-- Subqueries

SELECT *
FROM employee_demographics
WHERE employee_id IN 
					(SELECT employee_id
						FROM employee_salary
                        WHERE dept_id = 1
);

SELECT first_name, salary,
(SELECT AVG(salary)
FROM employee_salary) AS avg_salary
FROM employee_salary;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;

SELECT AVG(max_age)
FROM
(SELECT gender, 
	AVG(age) AS avg_age, 
	MAX(age) AS max_age, 
	MIN(age) AS min_age, 
	COUNT(age) AS count_age
FROM employee_demographics
GROUP BY gender) AS agg_table;


-- Window Functions

SELECT gender, AVG(salary) AS avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender;

SELECT dem.first_name, dem.last_name, gender, AVG(salary) OVER(PARTITION BY gender) 
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;

-- Rolling Total
SELECT dem.first_name, dem.last_name, gender, salary,
	SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS rolling_total
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;

-- Row Number
SELECT DEM.employee_id, dem.first_name, dem.last_name, gender, salary,
	ROW_NUMBER() OVER(PARTITION BY gender ORDER BY SALARY DESC)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;

-- Rank
SELECT DEM.employee_id, dem.first_name, dem.last_name, gender, salary,
	ROW_NUMBER() OVER(PARTITION BY gender ORDER BY SALARY DESC) AS row_num,
    RANK() OVER(PARTITION BY gender ORDER BY SALARY DESC) AS rank_num
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;

-- Dense Rank
SELECT DEM.employee_id, dem.first_name, dem.last_name, gender, salary,
	ROW_NUMBER() OVER(PARTITION BY gender ORDER BY SALARY DESC) AS row_num,
    RANK() OVER(PARTITION BY gender ORDER BY SALARY DESC) AS rank_num,
    DENSE_RANK() OVER(PARTITION BY gender ORDER BY SALARY DESC) AS dense_rank_num
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id;

