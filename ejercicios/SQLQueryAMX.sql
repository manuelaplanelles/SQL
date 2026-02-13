--EXERCISE 1
SELECT job_title as Job,
	concat(CAST (AVG (salary) as DECIMAL (8,2)), ' €') AS Avarage_Salary

FROM employees, jobs
WHERE employees.job_id = jobs.job_id
GROUP BY job_title
HAVING AVG (salary) > 10000
ORDER BY Avarage_Salary DESC

--EXERCISE 2
SELECT YEAR(hire_date) AS  Year_hire, 
	count (*) as Total_employees
FROM employees
GROUP BY year(hire_date)
HAVING COUNT (*) > 10