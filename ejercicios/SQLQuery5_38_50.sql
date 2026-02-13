--EXERCISE 38
select name surname 1, surname 2, namdep
from 
--exercise 39
select NameDep as Name_Departament, count(dni) as Total_Teacjers
from teacher, DEPARTMENT
where TEACHER NumDep=DEPARTMENT.NumDep
group by NameDep
--exercise 40
select Name; Surname1, Surname2, Mark
from TEACHER
where
--exercise 41
select DayAbsence, NameSubject
from SUBJECT,STUDENT_ABSENCE, STUDENT
where SUBJECT. NumSubject=STUDENT_ABSENCE.numsubject and
STUDENT_ABSENCE.DNIStudent=STUDENT.DNI and
NameStudent='Pedro' and Surname1='Marin' and Excuse='N'
--excercise 43
select NameStudent, Surname1, Surname2, YearCourse
from STUDENT, STUDENT_SUBJECT, SUBJECT, PROGRAM
where SUBJECT.NumProgram=PROGRAM.NumProgram and
Acronim='DAW' and SUBJECT.NumSubject
--excercise 44
select NameSubject
from SUBJECT, PROGRAM
where SUBJECT.NumProgram=PROGRAM.NumProgram and name 'Desarrollo de aplicaciones multiplataforma'
--excercise 45
select NameStudent, Surname1, YearCourse, avg(mark)
from STUDENT, STUDENT_SUBJECT
where STUDENT.DNIStudent=STUDENT_SUBJECT.DNIStudent and
NameStudent='Pedro' and Surname1='Marin'
group by NameStudent, Surname1, YearCourse

--excercise 46
select NameStudent, Surname1
from SUBJECT, STUDENT, STUDENT_SUBJECT
where STUDENT.DNIStudent=STUDENT_SUBJECT.DNIStudent AND SUBJECT.NumSubject=STUDENT_SUBJECT

--excercise 47
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

--excercise 48
select
from STUDENT, SUBJECT, STUDENT_SUBJECT
where STUDENT.DNIStudent=STUDENT_SUBJECT.DNIStudent and YearCourse=2019 and LenguageSubject='E'

--excercise 49
select Name, Surname1, NameSubject
from TEACHER, TEACHER_SUBJECT, SUBJECT
where TEACHER.DNI=TEACHER_SUBJECT.DNITeacher and 
SUBJECT.NumSubject=TEACHER_SUBJECT.NumSubject and
YearCourse='2017'

--excercise 50
select NameStudent, Surnamel, year(dayabsence) as Year_Course, count(dauansemce) as NumAbsences
from 
where 

