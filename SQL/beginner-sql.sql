-- Select Statement

SELECT *
FROM employee_demographics;

SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT 
	first_name, 
	last_name, 
	birth_date,
    age,
    age + 10
FROM parks_and_recreation.employee_demographics;

SELECT 
	first_name, 
	last_name, 
	birth_date,
    age,
    (age + 10) * 10
FROM parks_and_recreation.employee_demographics;

SELECT DISTINCT gender
FROM parks_and_recreation.employee_demographics;

SELECT DISTINCT first_name, gender
FROM parks_and_recreation.employee_demographics;


-- Where Clause

SELECT *
FROM employee_salary
WHERE first_name = 'Leslie';

SELECT *
FROM employee_salary
WHERE salary > 50000;

SELECT *
FROM employee_salary
WHERE salary >= 50000;

SELECT *
FROM employee_demographics
WHERE gender = 'Female';

SELECT *
FROM employee_demographics
WHERE gender != 'Female';

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01';


-- AND OR NOT -- Logical Operators

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
AND gender = 'Male';

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR gender = 'Male';

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'Male';

SELECT *
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44)
OR age > 55;


-- LIKE Statement

SELECT *
FROM employee_demographics
WHERE first_name = 'Jer';

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'Jer%';

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'A__';

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'A___%';

SELECT *
FROM employee_demographics
WHERE birth_date LIKE '1989%';


-- Group By

SELECT gender
FROM employee_demographics
GROUP BY gender;

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender;

SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary;

SELECT 
	gender, 
	AVG(age), 
    MAX(age), 
    MIN(age), 
    COUNT(age)
FROM employee_demographics
GROUP BY gender;


-- Order By

SELECT *
FROM employee_demographics
ORDER BY first_name;

SELECT *
FROM employee_demographics
ORDER BY first_name DESC;

SELECT *
FROM employee_demographics
ORDER BY gender, age;

SELECT *
FROM employee_demographics
ORDER BY 5, 4;

-- Having vs Where

SELECT gender, AVG(age)
FROM employee_demographics
WHERE AVG(age) > 40
GROUP BY gender;

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;

SELECT occupation, AVG(salary)
FROM employee_salary
GROUP BY occupation;

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 75000;


-- Limit

SELECT *
FROM employee_demographics
LIMIT 3;

SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 3;

SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 2, 1;


-- Aliasing

SELECT gender, AVG(age) AS avg_age
FROM employee_demographics
GROUP BY GENDER
HAVING avg_age > 40;

SELECT gender, AVG(age) avg_age
FROM employee_demographics
GROUP BY GENDER
HAVING avg_age > 40;

