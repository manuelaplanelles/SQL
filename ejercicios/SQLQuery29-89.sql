--EXERCISE 01
SELECT (*)
FROM STUDENTS
ORDER BY Surname1 ASC

--EXERCISE 02
SELECT (*)
FROM STUDENTS
WHERE Name LIKE 'A%'

--EXERCISE 03
SELECT (*)
FROM STUDENTS
WHERE City = 'San Vicente'

--EXERCISE 04
SELECT (*)
FROM STUDENTS
WHERE City IN ('Alicante', 'Elche');

--EXERCISE 05
SELECT (*)
FROM STUDENTS
WHERE Surname1 = 'Gonzalez' OR Surname2 = 'Gonzalez'

--EXERCISE 06
SELECT DNI, Name, Surname1, Surname2
FROM STUDENTS
WHERE DateOfBirth < '1980-12-31'

--EXERCISE 07
SELECT Name, Surname1
FROM STUDENTS
WHERE Name LIKE '____'

--EXERCISE 08
SELECT Name, Surname1, Phone
FROM STUDENTS
WHERE Name LIKE '%R'

--EXERCISE 09
SELECT DNI, Name, Surname1, Phone
FROM STUDENTS
WHERE DNI != 'Pepe' AND DNI != 'Antonio'

--EXERCISE 10
SELECT Name, Surname1, Surname2, City
FROM STUDENTS
WHERE DateOfBirth >= '1974-01-01' AND DateOfBirth <= '1978-12-31';

--EXERCISE 11
SELECT Name, Surname1, City, Phone
FROM STUDENTS
WHERE City = 'Elche' AND Phone LIKE '66%'

--EXERCISE 12
SELECT COUNT (*) as Total_Per_City
FROM STUDENTS

--EXERCISE 13
SELECT Name, COUNT (*) as Total_Joses
FROM STUDENTS
WHERE Name = 'Jose'
GROUP BY Name

--EXERCISE 14
SELECT City, COUNT (*) as Total_Per_City
FROM STUDENTS
GROUP BY City


--EXERCISE 15
--EXERCISE 16
--EXERCISE 17
--EXERCISE 18
--EXERCISE 19
--EXERCISE 20


--EXERCISE 21
--EXERCISE 22
--EXERCISE 23


--EXERCISE 24
--EXERCISE 25


--EXERCISE 26
--EXERCISE 27
--EXERCISE 28
--EXERCISE 29
--EXERCISE 30

--LUCENTUM
--EXERCISE 31
--EXERCISE 32
--EXERCISE 33
--EXERCISE 34
--EXERCISE 35
--EXERCISE 36
--EXERCISE 37
--EXERCISE 38
--EXERCISE 39
select NameDep as Name_Departament, count(dni) as Total_Teacjers
from teacher, DEPARTMENT
where TEACHER NumDep=DEPARTMENT.NumDep
group by NameDep
--EXERCISE 40
select Name; Surname1, Surname2, Mark
from TEACHER
where
--EXERCISE 41
select DayAbsence, NameSubject
from SUBJECT,STUDENT_ABSENCE, STUDENT
where SUBJECT. NumSubject=STUDENT_ABSENCE.numsubject and
STUDENT_ABSENCE.DNIStudent=STUDENT.DNI and
NameStudent='Pedro' and Surname1='Marin' and Excuse='N'
--EXERCISE 42
--EXERCISE 43
select NameStudent, Surname1, Surname2, YearCourse
from STUDENT, STUDENT_SUBJECT, SUBJECT, PROGRAM
where SUBJECT.NumProgram=PROGRAM.NumProgram and
Acronim='DAW' and SUBJECT.NumSubject
--EXERCISE 44
select NameSubject
from SUBJECT, PROGRAM
where SUBJECT.NumProgram=PROGRAM.NumProgram and name 'Desarrollo de aplicaciones multiplataforma'
--EXERCISE 45
select NameStudent, Surname1, YearCourse, avg(mark)
from STUDENT, STUDENT_SUBJECT
where STUDENT.DNIStudent=STUDENT_SUBJECT.DNIStudent and
NameStudent='Pedro' and Surname1='Marin'
group by NameStudent, Surname1, YearCourse
--EXERCISE 46
select NameStudent, Surname1
from SUBJECT, STUDENT, STUDENT_SUBJECT
where STUDENT.DNIStudent=STUDENT_SUBJECT.DNIStudent AND SUBJECT.NumSubject=STUDENT_SUBJECT
--EXERCISE 47
select Name, sum(HoursSubject) as TOTAL_HOURS
from SUBJECT, PROGRAM
where SUBJECT.NumProgram=PROGRAM.NumProgram 
group by Name

--el mismo ejercicio que el anterior pero que se visualicen
--los programas con mas de 150 horas
select Name, sum(HoursSubject) as TOTAL_HOURS
from SUBJECT, PROGRAM
where SUBJECT.NumProgram=PROGRAM.NumProgram 
group by Name
having sum(HoursSubject)>150
--EXERCISE 48
select
from STUDENT, SUBJECT, STUDENT_SUBJECT
where STUDENT.DNIStudent=STUDENT_SUBJECT.DNIStudent and YearCourse=2019 and LenguageSubject='E'
--EXERCISE 49
select Name, Surname1, NameSubject
from TEACHER, TEACHER_SUBJECT, SUBJECT
where TEACHER.DNI=TEACHER_SUBJECT.DNITeacher and 
SUBJECT.NumSubject=TEACHER_SUBJECT.NumSubject and
YearCourse='2017'
--EXERCISE 50
select NameStudent, Surnamel, year(dayabsence) as Year_Course, count(dauansemce) as NumAbsences
from 
where 


--UNIVERSITY
--EXERCISE 51
select Name, surname1, surname2, date_birth,
datediff(day, date_birth,getdate())/365 as Age     --me calcula los dias vividos y los debido en 365. para calcular los años por dias
from MEMBER
where type='alumno' and datediff(day, date_birth, getdate())/365<22
--EXERCISE 52
--EXERCISE 53
--EXERCISE 54
select name_depart, count (id_teacher) as Total_teachers
from TEACHER_DEPARTMENT, DEPARTMENT
where TEACHER_DEPARTMENT.id_depart=DEPARTMENT.id_depart
group by name_depart
having count(id_teacher)>2
--EXERCISE 55
--EXERCISE 56
select name, surname1, surname2, name_depart
from DEPARTMENT, TEACHER_DEPARTMENT, SUBJECT, MEMBER
where MEMBER.id_member=TEACHER_DEPARTMENT.id_teacher 
and SUBJECT.id_teacher=TEACHER_DEPARTMENT.id_teacher 
and DEPARTMENT.id_depart=TEACHER_DEPARTMENT.id_depart 
group by name, surname1, surname2, name_depart
having count(id_subject)>=2
--EXERCISE 57
--EXERCISE 58
select concat(year_start,'-',year_end) as Course, count(id_student) as Total_Students
from COURSE, STUDENT_SUBJECT
where COURSE.id_course=STUDENT_SUBJECT.id_course
group by year_start,year_end
--EXERCISE 59
select sum(credits)*30 as Money_to_pay
from MEMBER, STUDENT_SUBJECT, SUBJECT
where MEMBER.name='Inma' 
and MEMBER.surname1='Lakin' 
and MEMBER.id_member=STUDENT_SUBJECT.id_student 
and STUDENT_SUBJECT.id_subject=SUBJECT.id_subject
--EXERCISE 60
--EXERCISE 61
--EXERCISE 62
--EXERCISE 63



--AMX
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


--FILMS
--EXERCISE 90
SELECT R.Rev_Name, M.Title, RA.Stars
FROM REVIEWER R, RATING RA, MOVIE M
WHERE R.Rev_ID = RA.Rev_ID
  AND RA.Movie_ID = M.Movie_ID
  AND R.Rev_Name IS NOT NULL
  AND RA.Stars IS NOT NULL
ORDER BY RA.Stars DESC
--EXERCISE 91
SELECT M.Title, RA.Stars
FROM MOVIE M, RATING RA
WHERE M.Movie_ID = RA.Movie_ID
  AND RA.Stars IS NOT NULL
ORDER BY M.Title ASC
--EXERCISE 92
SELECT A.NameActor, A.SurnameActor, A.Gender, MC.Role
FROM ACTOR A, MOVIE_CAST MC, MOVIE M
WHERE A.NumActor = MC.NumActor
  AND MC.Movie_ID = M.Movie_ID
  AND M.Title = 'Annie Hall'
--EXERCISE 93
SELECT D.D_Name, D.D_Surname, M.MovieYear, M.Country
FROM DIRECTOR D, MOVIE_DIRECTION MD, MOVIE M
WHERE D.Dir_ID = MD.Dir_ID
  AND MD.Movie_ID = M.Movie_ID
  AND M.Title = 'Eyes Wide Shut'
--EXERCISE 94
SELECT D.D_name, D.D_Surname, COUNT(MD.Movie_ID) AS TOTAL_FILMS
FROM DIRECTOR D, MOVIE_DIRECTION MD
WHERE D.Dir_ID = MD.Dir_ID
GROUP BY D.D_name, D.D_Surname
ORDER BY D.D_Surname ASC
--EXERCISE 95
SELECT M.Title, M.DateRelease, M.MovieYear
FROM MOVIE M, MOVIE_GENRES MG, GENRES G
WHERE M.Movie_ID = MG.Movie_ID
  AND MG.Gen_ID = G.Gen_ID
  AND G.GenTitle = 'Drama'
ORDER BY M.MovieYear DESC
--EXERCISE 96
SELECT A.NameActor + ' ' + A.SurnameActor AS Actor, M.Title, MC.Role
FROM ACTOR A, MOVIE_CAST MC, MOVIE M
WHERE A.NumActor = MC.NumActor
  AND MC.Movie_ID = M.Movie_ID
ORDER BY Actor ASC
--EXERCISE 97
SELECT M.Title, R.Rev_name, RA.Stars
FROM MOVIE M, RATING RA, REVIEWER R
WHERE M.Movie_ID = RA.Movie_ID
  AND RA.Rev_ID = R.Rev_ID
  AND R.Rev_name <> 'Paul Monks'
ORDER BY M.Title ASC
--EXERCISE 98
SELECT M.Title, M.Language, M.Country, RA.Stars
FROM MOVIE M, MOVIE_DIRECTION MD, DIRECTOR D, RATING RA
WHERE M.Movie_ID = MD.Movie_ID
  AND MD.Dir_ID = D.Dir_ID
  AND M.Movie_ID = RA.Movie_ID
  AND D.D_name = 'James'
  AND D.D_Surname = 'Cameron'
ORDER BY RA.Stars DESC
--EXERCISE 99
SELECT DISTINCT A.NameActor, A.SurnameActor
FROM ACTOR A, MOVIE_CAST MC, MOVIE_DIRECTION MD, DIRECTOR D
WHERE A.NumActor = MC.NumActor
  AND MC.Movie_ID = MD.Movie_ID
  AND MD.Dir_ID = D.Dir_ID
  AND ((D.D_name = 'James' AND D.D_Surname = 'Cameron')
       OR (D.D_name = 'Danny' AND D.D_Surname = 'Boyle'))
--EXERCISE 100
SELECT M.Title, 
       D.D_name + ' ' + D.D_Surname AS Director, 
       M.Country
FROM MOVIE M, MOVIE_DIRECTION MD, DIRECTOR D, MOVIE_GENRES MG, GENRES G
WHERE M.Movie_ID = MD.Movie_ID
  AND MD.Dir_ID = D.Dir_ID
  AND M.Movie_ID = MG.Movie_ID
  AND MG.Gen_ID = G.Gen_ID
  AND G.GenTitle = 'Drama'
--EXERCISE 101
SELECT D.D_name + ' ' + D.D_Surname AS Director
FROM DIRECTOR D, MOVIE_DIRECTION MD
WHERE D.Dir_ID = MD.Dir_ID
GROUP BY D.D_name, D.D_Surname
HAVING COUNT(MD.Movie_ID) >= 2
--GARDENING
--EXERCISE 102
SELECT City, Postal_code
FROM office
WHERE Country = 'Spain'
--EXERCISE 103
SELECT COUNT(*) AS EMPLOYEES
FROM employee
WHERE Code_boss IS NOT NULL
--EXERCISE 104
SELECT Name, Surname1, Surname2
FROM employee
WHERE Code_boss IS NULL
--EXERCISE 105
SELECT COUNT(*) AS TOTAL_CLIENTS
FROM client
WHERE Country IN ('USA', 'Canada')
--EXERCISE 106
SELECT Country, COUNT(*) AS TOTAL_CLIENTS
FROM client
GROUP BY Country
--EXERCISE 107
SELECT C.Name_client, E.Name AS Sales_employee, C.Country
FROM client C, employee E
WHERE C.Code_employee_sales = E.Code_employee
  AND C.Country IN ('France', 'United Kingdom')
--EXERCISE 108
SELECT C.Name_client, P.Payment_date, P.Id_transaction
FROM client C, payment P
WHERE C.Cod_client = P.Cod_client
  AND YEAR(P.Payment_date) = 2007
--EXERCISE 109
SELECT E.Name, E.Surname1, E.Surname2
FROM employee E, office O
WHERE E.Code_office = O.Code_office
  AND O.City = 'Barcelona'
--EXERCISE 110
SELECT DISTINCT C.Name_client
FROM client C, orders O
WHERE C.Cod_client = O.Code_client
  AND C.City = 'Fuenlabrada'
--EXERCISE 111
SELECT OD.Code_order, SUM(OD.Quantity * OD.Unit_price) AS TOTAL
FROM order_detail OD
GROUP BY OD.Code_order
--EXERCISE 112
SELECT C.Name_client, O.Order_date, O.Expected_date, O.Delivery_date
FROM client C, orders O
WHERE C.Cod_client = O.Code_client
  AND O.Delivery_date > O.Expected_date
ORDER BY O.Order_date ASC
--EXERCISE 113
SELECT P.Code_product AS CODE, P.Name, COUNT(*) AS No_TIMES
FROM product P, order_detail OD
WHERE P.Code_product = OD.Code_product
GROUP BY P.Code_product, P.Name
ORDER BY P.Code_product ASC
--EXERCISE 114
SELECT C.Name_client, SUM(P.Total) AS TOTAL
FROM client C, payment P
WHERE C.Cod_client = P.Cod_client
  AND YEAR(P.Payment_date) = 2007
GROUP BY C.Name_client
--EXERCISE 115
SELECT R.Range, COUNT(P.Code_product) AS No_PRODUCTS
FROM range_product R, product P
WHERE R.Range = P.Range
GROUP BY R.Range
--EXERCISE 116
SELECT OD.Code_order, P.Name, P.Price, OD.Unit_price
FROM order_detail OD, product P
WHERE OD.Code_product = P.Code_product
  AND P.Range = 'Herramientas'
  AND OD.Unit_price > P.Price
--EXERCISE 117
SELECT Code_order, COUNT(*) AS TOTAL_PRODUCTS
FROM order_detail
GROUP BY Code_order
HAVING COUNT(*) > 6
--EXERCISE 118
SELECT DISTINCT O.Code_office, O.City, O.Address1
FROM office O, employee E, client C
WHERE O.Code_office = E.Code_office
  AND E.Code_employee = C.Code_employee_sales
  AND C.City = 'Fuenlabrada'
--EXERCISE 119
SELECT C.City, COUNT(*) AS TOTAL_CLIENTS
FROM client C
WHERE C.City LIKE 'M%'
GROUP BY C.City
--EXERCISE 120
SELECT O.City, COUNT(E.Code_employee) AS TOTAL_EMPLOYEE
FROM office O, employee E
WHERE O.Code_office = E.Code_office
GROUP BY O.City
--EXERCISE 121
SELECT Name, Surname1, Surname2, Position
FROM employee
WHERE Position <> 'Representante ventas'
--EXERCISE 122
SELECT SUM(Total) AS TOTAL_BILLS
FROM payment
WHERE YEAR(Payment_date) = 2009
--EXERCISE 123
SELECT MIN(Price) AS MIN_PRICE, MAX(Price) AS MAX_PRICE
FROM product
--EXERCISE 124
SELECT YEAR(Payment_date) AS YEAR,
       SUM(Total) - SUM(Total * 0.21) AS SUBTOTAL,
       SUM(Total * 0.21) AS IVA,
       SUM(Total) AS TOTAL
FROM payment
GROUP BY YEAR(Payment_date)
--EXERCISE 125
SELECT C.Country, COUNT(O.Code_order) AS TOTAL_CLIENT
FROM client C, orders O
WHERE C.Cod_client = O.Code_client
GROUP BY C.Country
ORDER BY TOTAL_CLIENT DESC
--EXERCISE 126
SELECT E.Name, E.Surname1, E.Surname2, COUNT(C.Cod_client) AS Total_clients
FROM employee E, client C
WHERE E.Code_employee = C.Code_employee_sales
  AND E.Position = 'Representante ventas'
GROUP BY E.Name, E.Surname1, E.Surname2
ORDER BY E.Surname1 ASC, E.Surname2 ASC
--EXERCISE 127
SELECT OD.Code_order, SUM(OD.Quantity * OD.Unit_price) AS Total
FROM order_detail OD
GROUP BY OD.Code_order
--EXERCISE 128
SELECT TOP 10 P.Name, SUM(OD.Quantity) AS Total
FROM product P, order_detail OD
WHERE P.Code_product = OD.Code_product
GROUP BY P.Name
ORDER BY Total DESC
--EXERCISE 129
SELECT P.Name, 
       SUM(OD.Quantity) AS Total_units,
       SUM(OD.Quantity * OD.Unit_price) AS Subtotal,
       SUM(OD.Quantity * OD.Unit_price * 1.21) AS Total
FROM product P, order_detail OD
WHERE P.Code_product = OD.Code_product
GROUP BY P.Name
HAVING SUM(OD.Quantity * OD.Unit_price * 1.21) > 4000
--EXERCISE 130
SELECT COUNT(*) AS TOTAL_MADRID
FROM client
WHERE City = 'Madrid'
--EXERCISE 131
SELECT C.Name_client, COUNT(O.Code_order) AS Total_orders
FROM client C, orders O
WHERE C.Cod_client = O.Code_client
  AND YEAR(O.Order_date) = 2008
GROUP BY C.Name_client
HAVING COUNT(O.Code_order) > 3
--EXERCISE 132
SELECT TOP 1 C.Country, COUNT(O.Code_order) AS NUM_ORDERS
FROM client C, orders O
WHERE C.Cod_client = O.Code_client
GROUP BY C.Country
ORDER BY NUM_ORDERS ASC
--EXERCISE 133
SELECT TOP 2 P.Name, SUM(OD.Quantity) AS Total
FROM product P, order_detail OD, orders O
WHERE P.Code_product = OD.Code_product
  AND OD.Code_order = O.Code_order
  AND YEAR(O.Order_date) = 2008
GROUP BY P.Name
ORDER BY Total DESC
--EXERCISE 134
SELECT O.Code_order, C.Name_client, O.Expected_date, O.Delivery_date
FROM orders O, client C
WHERE O.Code_client = C.Cod_client
  AND YEAR(O.Order_date) = 2008
  AND O.Delivery_date > O.Expected_date
--EXERCISE 135
SELECT C.Name_client, O.Expected_date, O.Delivery_date
FROM client C, orders O
WHERE C.Cod_client = O.Code_client
  AND YEAR(O.Order_date) = 2007
  AND DATEDIFF(DAY, O.Expected_date, O.Delivery_date) >= 2
--EXERCISE 136
SELECT O.Code_order, C.Name_client, YEAR(O.Delivery_date) AS year_delivery
FROM orders O, client C
WHERE O.Code_client = C.Cod_client
  AND MONTH(O.Delivery_date) = 1
  AND YEAR(O.Delivery_date) IN (2006, 2007)
ORDER BY year_delivery DESC
--EXERCISE 137
SELECT C.Name_client, SUM(P.Total) AS TOTAL_PAYMENTS
FROM client C, payment P
WHERE C.Cod_client = P.Cod_client
GROUP BY C.Name_client
ORDER BY TOTAL_PAYMENTS DESC
--EXERCISE 138
SELECT C.Name_client, 
       E.Name + ' ' + E.Surname1 + ' ' + E.Surname2 AS SALESMAN, 
       O.City AS CITY_OFFICE
FROM client C, employee E, office O
WHERE C.Code_employee_sales = E.Code_employee
  AND E.Code_office = O.Code_office
ORDER BY SALESMAN ASC
--EXERCISE 139
SELECT C.Name_client, COUNT(O.Code_order) AS NUM_ORDERS
FROM client C, orders O
WHERE C.Cod_client = O.Code_client
  AND YEAR(O.Order_date) = 2008
GROUP BY C.Name_client
ORDER BY C.Name_client ASC
--EXERCISE 140
SELECT Name + ' ' + Surname1 + ' ' + ISNULL(Surname2, '') AS EMPLOYEE
FROM employee
WHERE Position <> 'Representante ventas'
ORDER BY Surname1 ASC
--EXERCISE 141
SELECT DISTINCT C.Name_client
FROM client C, orders O
WHERE C.Cod_client = O.Code_client
  AND YEAR(O.Order_date) = 2009
  AND O.Status = 'Rechazado'
ORDER BY C.Name_client ASC
--EXERCISE 142
SELECT C.Name_client, P.Id_transaction, P.Payment_date, P.Total
FROM client C, payment P
WHERE C.Cod_client = P.Cod_client
  AND P.Payment_method = 'PayPal'
  AND YEAR(P.Payment_date) = 2009
ORDER BY P.Total DESC
--EXERCISE 143
SELECT DISTINCT Payment_method
FROM payment
--EXERCISE 144
SELECT DISTINCT C.Name_client
FROM client C, orders O, order_detail OD, product P
WHERE C.Cod_client = O.Code_client
  AND O.Code_order = OD.Code_order
  AND OD.Code_product = P.Code_product
  AND P.Name LIKE '%granado%'
ORDER BY C.Name_client ASC
--EXERCISE 145
SELECT Name, Price
FROM product
WHERE Range = 'Ornamentales'
  AND Quantity_stock > 100
ORDER BY Price DESC
--EXERCISE 146
SELECT DISTINCT C.Name_client, O.Code_order, O.Expected_date
FROM client C, orders O
WHERE C.Cod_client = O.Code_client
  AND O.Status = 'Pendiente'
--EXERCISE 147
SELECT C.Name_client
FROM client C
WHERE C.City = 'Madrid'
  AND C.Code_employee_sales IN (11, 30)
--EXERCISE 148
SELECT E.Name + ' ' + E.Surname1 + ' ' + ISNULL(E.Surname2, '') AS Employee, 
       O.City
FROM employee E, office O
WHERE E.Code_office = O.Code_office
  AND E.Position = 'Director Oficina'
ORDER BY O.City ASC
--EXERCISE 149
SELECT DISTINCT P.Name AS Name_product, C.Name_client
FROM product P, order_detail OD, orders O, client C
WHERE P.Code_product = OD.Code_product
  AND OD.Code_order = O.Code_order
  AND O.Code_client = C.Cod_client
  AND P.Range = 'Aromáticas'
  AND YEAR(O.Order_date) = 2008
--EXERCISE 150
SELECT O.City, COUNT(E.Code_employee) AS Number_of_employees
FROM office O, employee E
WHERE O.Code_office = E.Code_office
GROUP BY O.City
ORDER BY Number_of_employees DESC