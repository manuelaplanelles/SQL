--SUBQUERIES
--Ejercicio 151
SELECT NameSubject AS SUBJECT, HoursSubject AS HOURS
FROM SUBJECT
WHERE HoursSubject > 
	(SELECT HoursSubject AS HOURS
	FROM SUBJECT
	WHERE NameSubject = 'Lenguaje de marcas')

--Ejercicio 152
SELECT NameStudent as STUDENT, Mark as MARK
FROM STUDENT, STUDENT_SUBJECT
WHERE STUDENT.DNI=STUDENT_SUBJECT.DNIStudent
	AND Mark =
		(SELECT MAX (Mark) as MARK
		FROM STUDENT_SUBJECT, SUBJECT
		WHERE SUBJECT.NumSubject=STUDENT_SUBJECT.NumSubject 
			AND NameSubject = 'Acceso a datos'
			AND YearCourse = 2018)

--Ejercicio 153
SELECT NameStudent, Surname1, NameSubject, Mark
FROM STUDENT, STUDENT_SUBJECT, SUBJECT
WHERE STUDENT.DNI=STUDENT_SUBJECT.DNIStudent
	AND STUDENT_SUBJECT.NumSubject=SUBJECT.NumSubject
	AND Mark >
	(SELECT AVG (Mark) AS MARK
	FROM STUDENT_SUBJECT
	WHERE YearCourse = 2019)

--Ejercicio 154
SELECT Name, Surname1, YearCourse
FROM TEACHER, TEACHER_SUBJECT, SUBJECT
WHERE TEACHER.DNI=TEACHER_SUBJECT.DNITeacher
	AND NameSubject in
		(SELECT NameSubject
		FROM TEACHER, TEACHER_SUBJECT, SUBJECT
		WHERE TEACHER.DNI=TEACHER_SUBJECT.DNITeacher
			AND TEACHER_SUBJECT.NumSubject=SUBJECT.NumSubject
			AND YearCourse = 2017
			AND Name = 'Antonio'
			AND Surname1 = 'Martínez')
--Ejercicio 155
SELECT NameStudent, Surname1, COUNT (DayAbsence) AS DayAbsence
FROM STUDENT, STUDENT_ABSENCE, SUBJECT
WHERE STUDENT.DNI=STUDENT_ABSENCE.DNIStudent
	AND STUDENT_ABSENCE.NumSubject = SUBJECT.NumSubject
	AND NameSubject = 'Despliegue de aplicaciones web'
GROUP BY NameStudent, Surname1
HAVING COUNT (DayAbsence) >
		(SELECT COUNT (DayAbsence)
		FROM STUDENT_ABSENCE, SUBJECT, STUDENT
		WHERE STUDENT_ABSENCE.numsubject=SUBJECT.NumSubject
			AND STUDENT.DNI=STUDENT_ABSENCE.DNIStudent
			AND NameSubject = 'Despliegue de aplicaciones web'
			AND NameStudent = 'Pilar'
			AND Surname1 = 'Cea')

--Ejercicio 156
SELECT NameStudent, Surname1, Mark, NameSubject
FROM STUDENT_SUBJECT, STUDENT, SUBJECT
WHERE  STUDENT_SUBJECT.DNIStudent=STUDENT.DNI
	AND STUDENT_SUBJECT.numsubject=SUBJECT.NumSubject
	AND YearCourse = 2019
	AND Mark =
	(SELECT MAX (Mark)
	FROM STUDENT_SUBJECT
	WHERE YearCourse = 2019)

--Ejercicio 157 --- DUDA UNIR TAMBLA DE SUBJECT CON DEPART
SELECT CONCAT (name, ' ',  surname1, ' ', surname2) as Teacher, name_subject
FROM TEACHER_DEPARTMENT, SUBJECT, MEMBER, DEPARTMENT
WHERE TEACHER_DEPARTMENT.id_teacher=MEMBER.id_member
	AND DEPARTMENT.id_depart=TEACHER_DEPARTMENT.id_depart
	AND TEACHER_DEPARTMENT.id_teacher=SUBJECT.id_teacher
	AND MEMBER.type = 'prodesor'
	AND id_depart =
		(SELECT id_depart
		FROM DEPARTMENT, TEACHER_DEPARTMENT, MEMBER
		WHERE DEPARTMENT.id_depart=TEACHER_DEPARTMENT.id_depart
			AND TEACHER_DEPARTMENT.id_teacher=MEMBER.id_member
			AND name = 'Esther'
			AND surname1 = 'Spencer')

--Ejercicio 158 ---> NO CONSIGO ENTENDER PORQUE ES IN Y NO =
SELECT name, surname1, surname2, name_subject
FROM MEMBER, STUDENT_SUBJECT, SUBJECT
WHERE MEMBER.id_member = STUDENT_SUBJECT.id_student
	AND STUDENT_SUBJECT.id_subject = SUBJECT.id_subject
	AND name_subject IN
		(SELECT name_subject
		FROM MEMBER, SUBJECT, STUDENT_SUBJECT, COURSE
		WHERE MEMBER.id_member = STUDENT_SUBJECT.id_student
			AND STUDENT_SUBJECT.id_subject = SUBJECT.id_subject
			AND STUDENT_SUBJECT.id_course = COURSE.id_course
			AND name = 'Salvador'
			AND surname1 = 'Sánchez'
			AND MEMBER.type = 'alumno'
			AND year_start = '2014'
			AND year_end = '2015')

--Ejercicio 159 ---DUDA
SELECT name, surname1, surname2
FROM MEMBER
WHERE MEMBER.type = 'profesor'
	AND id_member NOT IN
		(SELECT DISTINCT id_teacher
		FROM SUBJECT
		WHERE id_teacher = id_member) ---QUE NO TENGAS EL MISMO ID DE DENTRO Y EL DE FUERA
ORDER BY surname1, surname2

--Ejercicio 160 ---DUDA
SELECT CONCAT (name, ' ', surname1, ' ', surname2) AS Studedent, date_birth
FROM MEMBER
WHERE type = 'alumno' and id_member Not in
		(SELECT distinct id_student
		FROM STUDENT_SUBJECT)
ORDER BY Studedent

--Ejercicio 161
SELECT CONCAT (name, ' ', surname1, ' ', surname2) as Teacher, name_depart
FROM DEPARTMENT, TEACHER_DEPARTMENT, MEMBER
WHERE DEPARTMENT.id_depart=TEACHER_DEPARTMENT.id_depart
	AND TEACHER_DEPARTMENT.id_teacher=MEMBER.id_member
	AND MEMBER.type = 'profesor'
	AND name_depart =
		(SELECT name_depart
		FROM DEPARTMENT, TEACHER_DEPARTMENT, MEMBER
		WHERE DEPARTMENT.id_depart=TEACHER_DEPARTMENT.id_depart
			AND TEACHER_DEPARTMENT.id_teacher=MEMBER.id_member
			AND name = 'Aitor'
			AND surname1 = 'Menta')
--Ejercicio 162
SELECT first_name, last_name, salary, department_name, job_title
FROM employees, departments, jobs
WHERE jobs.job_id = employees.job_id
	and employees.department_id = departments.department_id
	and department_name =
		(SELECT department_name
		FROM employees, departments
		WHERE employees.department_id = departments.department_id
			and first_name = 'Daniel'
			and last_name = 'Faviet')

--Ejercicio 163
SELECT first_name, last_name, salary
FROM employees
WHERE salary >
		(SELECT salary
		FROM employees
		WHERE first_name = 'Michael'
			and last_name = 'Hartstein') 
ORDER BY salary DESC

--Ejercicio 164 --DUDA
SELECT first_name, last_name, department_name,salary
FROM employees, departments
WHERE employees.department_id = departments.department_id
  AND salary >= 2 * 
		(SELECT department_id, AVG(salary) AS avg_salary
		FROM employees
		GROUP BY department_id)
ORDER BY first_name, last_name

--Ejercicio 165 -- DUDA

--Ejercicio 166 -- DUDA
--Ejercicio 167
--Ejercicio 168
--Ejercicio 169 -- DUDA (DOS SUBQUERIS)
SELECT E.first_name, E.last_name, J.job_title
FROM employees, jobs
WHERE employees.job_id = jobs.job_id
  AND E.department_id NOT IN 
      (SELECT department_id
       FROM employees
       WHERE department_id IS NOT NULL
         AND ((first_name = 'Alexander' AND last_name = 'Hunold')
           OR (first_name = 'Adam' AND last_name = 'Fripp')
           OR (first_name = 'John' AND last_name = 'Russell')))
ORDER BY E.first_name, E.last_name
--Ejercicio 170
--Ejercicio 171
--Ejercicio 172


--Ejercicio 173
--Ejercicio 174
--Ejercicio 175
--Ejercicio 176
--Ejercicio 177
--Ejercicio 178
--Ejercicio 179
--Ejercicio 180
--Ejercicio 181
--Ejercicio 182
--Ejercicio 183

--Ejercicio 184
SELECT distinct Range
FROM product
WHERE Code_product not in  
      (SELECT Code_product
       FROM order_detail, orders
       WHERE order_detail.Code_order = orders.Code_order
		 AND YEAR(Order_date) = 2009)

--Ejercicio 185
SELECT DISTINCT Code_employee_sales
FROM client
WHERE Code_client IN 
      (SELECT client.Code_client
       FROM client, orders, order_detail, product
       WHERE client.Code_client = orders.Code_client
         AND orders.Code_order = order_detail.Code_order
         AND order_detail.Code_product = product.Code_product
         AND product.Range = 'Frutales')
-- opcion2 mismo ejercicio 185
SELECT DISTINCT Code_office
FROM employee
WHERE Code_employee IN 
      (SELECT DISTINCT Code_employee_sales
       FROM client
       WHERE Code_client IN 
             (SELECT client.Code_client
              FROM client, orders, order_detail, product
              WHERE client.Code_client = orders.Code_client
                AND orders.Code_order = order_detail.Code_order
                AND order_detail.Code_product = product.Code_product
                AND product.Range = 'Frutales'))

--Ejercicio 186
SELECT top 1 Name_client --(para que muerstre el numero de la lista)
FROM client
ORDER BY Credit_limit desc

	-- opcion 2
	SELECT Name_client
	FROM client
	WHERE Credit_limit = 
		(SELECT MAX (Credit_limit)
		FROM client)

	-- opcion 3
	SELECT name_cliente
	FROM client
	WHERE Credit_limit >= ALL
		(SELECT MAX (Credit_limit)
		FROM client)

--Ejercicio 187
SELECT TOP (1) Name
FROM product
ORDER BY Price DESC

	SELECT Name
		FROM product
		WHERE Price = 
			(SELECT MAX (Price)
			FROM product)

--Ejercicio 197 - T.EXAM
--Ejercicio 201 - T.EXAM
--Ejercicio 202 - T.EXAM
--Ejercicio 205 - T.EXAM
--Ejercicio 206 - T.EXAM
--Ejercicio 207 - T.EXAM
--Ejercicio 208 - T.EXAM
--Ejercicio 209 - T.EXAM
--Ejercicio 217 - T.EXAM
--Ejercicio 220 - T.EXAM
--Ejercicio 221 - T.EXAM
--Ejercicio 222 - T.EXAM
--Ejercicio 223 - T.EXAM
--Ejercicio 226 - T.EXAM
--Ejercicio 232 - T.EXAM
--Ejercicio 236 - T.EXAM
--Ejercicio 239 - T.EXAM
--Ejercicio 240 - T.EXAM
--Ejercicio 241 - T.EXAM


--JOIN
--Ejercicio 270
SELECT Physician.Name as Physician, Patient.Name as Patient, Medication.Name as Medication
FROM Physician
join Appointment on Physician.PhysicianID = Appointment.PhysicianID
join Prescribes on Prescribes.AppointmentID = Appointment.AppointmentID
join Patient on Patient.PatientSSN = Appointment.PatientSSN
join Medication on Prescribes.CodeMed = Medication.CodeMed

--Ejercicio 271
select Physician.Name,
       D1.Name as Actual_Department,
       D2.Name as Former_Department
from Physician
join Affiliated_With as A1 on Physician.PhysicianID = A1.PhysicianID
    and A1.PrimaryAffiliation = 1
join Department as D1 on A1.DepartmentID = D1.DepartmentID
join Affiliated_With as A2 on Physician.PhysicianID = A2.PhysicianID
    and A2.PrimaryAffiliation = 0
join Department as D2 on A2.DepartmentID = D2.DepartmentID

--Ejercicio 272
select Name, count(AppointmentID) as Total_appointments
from Physician
left join Appointment on Physician.PhysicianID = Appointment.PhysicianID
group by Physician.Name

--Ejercicio 273
select Patient.Name, 
       Physician.Name,
       count(Undergoes.CodeProcedure) as Total_treatments
from Patient
join Physician on Patient.PCP = Physician.PhysicianID
left join Undergoes on Patient.PatientSSN = Undergoes.PatientSSN
    and Undergoes.PhysicianID = Patient.PCP
group by Patient.Name, Physician.Name
