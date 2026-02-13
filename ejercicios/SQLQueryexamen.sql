--1. Display female nurses who have worked in any of the shifts that ALEJANDRO SAEZ SUAREZ 
-- worked, currently work in the same area where ALEJANDRO SAEZ SUAREZ works, and are older 
--than 55 years. Sort the result-set by name, then surnames
SELECT Name, Surnames, DATEDIFF(DAY, DateBirth,GETDATE())/365  as Age
FROM NURSE, EMPLOYEE
WHERE NURSE.LicenseNumber=EMPLOYEE.LicenseNumber
	and Gender = 'M'
	and DATEDIFF(DAY, DateBirth,GETDATE())/365 > 55
	and IdArea =
		(select IdArea
		from EMPLOYEE
		where Name = 'ALEJANDRO'
			and Surnames = 'SAEZ SUAREZ')
	and EMPLOYEE.LicenseNumber in 
		(select DESIGNATED.LicenseNumber
		from DESIGNATED
		where IdShift in 
			(select DESIGNATED.IdShift
			from EMPLOYEE, DESIGNATED
			where DESIGNATED.LicenseNumber=EMPLOYEE.LicenseNumber
				and Name = 'ALEJANDRO'
				and Surnames = 'SAEZ SUAREZ'))
ORDER BY Name, Surnames

--2.All doctors are awarded with 5 points for each appointment performed during the year 2014, 
--but only those doctors who have attended three or more different patients during the year 
--2014

--3.Display the doctor who has had more appointments than any of the doctors in the same 
--specialty.
Select Name, Surnames, TypeSpecialty, count (*) as Total_Appointments
from DOCTOR, LINE_HISTORY, EMPLOYEE
where EMPLOYEE.LicenseNumber=DOCTOR.LicenseNumber
	and DOCTOR.LicenseNumber=LINE_HISTORY.LicenseNumber
group by Name, Surnames, TypeSpecialty
having count(*)>= all
	(select count(*)
	from LINE_HISTORY,DOCTOR as D2
	where D2.LicenseNumber=LINE_HISTORY.LicenseNumber
		and D2.TypeSpecialty=DOCTOR.TypeSpecialty
	group by D2.LicenseNumber)

--4.Display the patients, the total number of operations performed on each of them, 
--and the estimated total cost of their operations

--5.Display the doctors whose specialty is 'Urgencias', are not Spanish, and are designated 
--to shifts but who never appear attend an appointment (LINE_HISTORY)
select DOCTOR.LicenseNumber, Name, Surnames, Nationality
from DOCTOR, EMPLOYEE, AREA
where DOCTOR.LicenseNumber = EMPLOYEE.LicenseNumber
	and EMPLOYEE.IdArea=AREA.IdArea
	and Type = 'Urgencias'
	and Nationality != 'ESPAÑOLA'

--6.Display the doctors whose total number of surgery hours exceeds the total hours of Dr. 
--JAIME LOPEZ FERNANDEZ.
select EMPLOYEE.Name, Surnames, TypeSpecialty, Nationality, SUM(Duration)  as T_minutes 
from OPERATION, LINE_HISTORY, DOCTOR, EMPLOYEE
where OPERATION.IdHistory=LINE_HISTORY.IdHistory
	and LINE_HISTORY.LicenseNumber=DOCTOR.LicenseNumber
	and DOCTOR.LicenseNumber=EMPLOYEE.LicenseNumber
	and EMPLOYEE.Name = 'JAIME'
	and Surnames ='LOPEZ FERNANDEZ'
group by EMPLOYEE.Name, Surnames, TypeSpecialty, Nationality
having SUM(Duration)>
	(select
	from  LINE_HISTORY, DOCTOR, EMPLOYEE, OPERATION
	where and LINE_HISTORY.LicenseNumber=DOCTOR.LicenseNumber
			and DOCTOR.LicenseNumber=EMPLOYEE.LicenseNumber 
			and OPERATION.IdHistory=LINE_HISTORY.IdHistory
				and EMPLOYEE.Name = 'JAIME'
			and Surnames ='LOPEZ FERNANDEZ')
order by SUM(Duration)

