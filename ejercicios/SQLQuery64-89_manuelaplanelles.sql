--EXERCISE 64
select department_name,
first_name + last_name AS Manager,
DATEDIFF(DAY, hire_date, GETDATE())/365 AS Years_working
from departments, employees
where departments.department_id = employees.department_id
order by Years_working DESC;

--EXERCISE 65
select department_name, salary
from departments, employees
where departments.department_id=employees.department_id
order by department_name

--EXERCISE 66 (duda)


--EXERCISE 67
select YEAR(hire_date) AS Year_hire, COUNT(employee_id) AS Total_employees
from employees
where YEAR(hire_date) BETWEEN 2017 AND 2019
group by YEAR(hire_date);

--EXERCISE 68
select job_title, datediff(year, hire_date, getdate()) as Years_working
from employees e, jobs j
where e.job_id = j.job_id
and first_name = 'Neena' and last_name = 'Kochhar';

--EXERCISE 69
select first_name, last_name, job_title, start_date, end_date, datediff(year, start_date, end_date) as Years_working
from employees e, job_history jh, jobs j
where e.employee_id = jh.employee_id 
and jh.job_id = j.job_id
and first_name = 'Neena' and last_name = 'Kochhar';

--EXERCISE 70
select job_id, job_title, min_salary, max_salary
from jobs
where min_salary > 10000;

--EXERCISE 71
select first_name, last_name, hire_date
from employees
where year(hire_date) between 2007 and 2009
order by hire_date;

--EXERCISE 72
select first_name, email, phone_number
from employees
where employee_id = 150 or employee_id = 160;

--EXERCISE 73
select first_name, phone_number, salary
from employees
where salary < 2500;

--EXERCISE 74
select region_name, count(country_id) as Total_countries
from regions r, countries c
where r.region_id = c.region_id
group by region_name
having count(country_id) in (5, 6);

--EXERCISE 75
select first_name, last_name
from employees
where first_name like 'W%' or last_name like 'W%';

--EXERCISE 76
select job_title, (max_salary - min_salary) as DIFFERENCE
from jobs
where max_salary between 10000 and 20000;

--EXERCISE 77
select first_name + ' ' + last_name as EMPLOYEE, email, hire_date
from employees
where hire_date > '2020-06-01'
order by first_name;

--EXERCISE 78
select first_name + ' ' + last_name as EMPLOYEE, job_id, hire_date
from employees
where job_id in ('IT_PROG', 'SA_MAN')
order by job_id, first_name;

--EXERCISE 79
select job_title, min_salary, max_salary
from jobs
order by job_title desc;

--EXERCISE 80
select first_name, last_name, job_id
from employees
where commission_pct is null 
and salary between 2000 and 3000 
and department_id = 30;

--EXERCISE 81
select first_name, hire_date, datediff(year, hire_date, getdate()) as YEARS_EXP
from employees
where datediff(year, hire_date, getdate()) > 11;

--EXERCISE 82
select first_name, email
from employees
where month(hire_date) = 5;

--EXERCISE 83
select upper(first_name + ' ' + last_name) as EMPLOYEE, lower(email) as EMAIL
from employees
where year(hire_date) between 2007 and 2011;

--EXERCISE 84
select manager_id, count(employee_id) as TOTAL_EMPLOYEES
from employees
where manager_id is not null
group by manager_id
having count(employee_id) > 5;

--EXERCISE 85
select job_id, count(employee_id) as TOTAL_EMPLOYEES, sum(salary) as SUM_SALARY, (max(salary) - min(salary)) as DIFFERENCE
from employees
group by job_id
having count(employee_id) > 5;

--EXERCISE 86
select country_id, country_name, count(city) as NUM_CITIES
from countries c, locations l
where c.country_id = l.country_id
group by country_id, country_name
having count(city) in (3, 4);

--EXERCISE 87
select jh.employee_id as EMP_ID, first_name + ' ' + last_name as EMPLOYEE, job_title as JOB, end_date as LAST_DAY
from employees e, job_history jh, jobs j
where e.employee_id = jh.employee_id 
and jh.job_id = j.job_id
and job_title = 'Stock Clerk';

--EXERCISE 88
select department_id, min(salary) as Min_salary
from employees
group by department_id;

--EXERCISE 89
select d.department_id, department_name, min(salary) as Min_salary
from departments d, employees e
where d.department_id = e.department_id
group by d.department_id, department_name;