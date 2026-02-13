--excercise 51
select Name, surname1, surname2, date_birth,
datediff(day, date_birth,getdate())/365 as Age     --me calcula los dias vividos y los debido en 365. para calcular los años por dias
from MEMBER
where type='alumno' and datediff(day, date_birth, getdate())/365<22

--excercise 54
select name_depart, count (id_teacher) as Total_teachers
from TEACHER_DEPARTMENT, DEPARTMENT
where TEACHER_DEPARTMENT.id_depart=DEPARTMENT.id_depart
group by name_depart
having count(id_teacher)>2

--excercise 56
select name, surname1, surname2, name_depart
from DEPARTMENT, TEACHER_DEPARTMENT, SUBJECT, MEMBER
where MEMBER.id_member=TEACHER_DEPARTMENT.id_teacher 
and SUBJECT.id_teacher=TEACHER_DEPARTMENT.id_teacher 
and DEPARTMENT.id_depart=TEACHER_DEPARTMENT.id_depart 
group by name, surname1, surname2, name_depart
having count(id_subject)>=2

--excercise 58
select concat(year_start,'-',year_end) as Course, count(id_student) as Total_Students
from COURSE, STUDENT_SUBJECT
where COURSE.id_course=STUDENT_SUBJECT.id_course
group by year_start,year_end

--excercise 59
select sum(credits)*30 as Money_to_pay
from MEMBER, STUDENT_SUBJECT, SUBJECT
where MEMBER.name='Inma' 
and MEMBER.surname1='Lakin' 
and MEMBER.id_member=STUDENT_SUBJECT.id_student 
and STUDENT_SUBJECT.id_subject=SUBJECT.id_subject

--excercise 61
select
from
