--DISPLAY THE TOTAL NUMBER OF APPOINTMENTS FOR EVERY DOCTOR
SELECT name, Surnames, COUNT (*) AS Total
FROM LINE_HISTORY, DOCTOR, EMPLOYEE
WHERE LINE_HISTORY.LicenseNumber=DOCTOR.LicenseNumber
AND DOCTOR.LicenseNumber=EMPLOYEE.LicenseNumber
GROUP BY name, Surnames

SELECT name, Surnames, COUNT (*) AS Total
FROM EMPLOYEE
JOIN LINE_HISTORY ON DOCTOR.LicenseNumber=LINE_HISTORY.LicenseNumber
JOIN DOCTOR ON EMPLOYEE.LicenseNumber=DOCTOR.LicenseNumber
GROUP BY name, Surnames

-- 01 DISPLAY PATIENTS WHO ARE ALLERGIR TO SULFAMIDAS LIVE ALICANTE
-- AND HAVE A HISTORY BUT NEVER HAD AN APPOINTMENT
-- SORT THE RESULT-SET ALPHABETICALLY BY ALLERGIES

-- 02 DISPLAY THE TESTS THAT COST MORE THAN THE AVERAGE COST OF ALL THE TESTS
SELECT TypeTest, EstimatedCost
FROM TEST
WHERE EstimatedCost >
	(select AVG (EstimatedCost)
	from TEST)

--03 DISPLAY THE PATIENTS (ID.HISTORY, NAME AND SURNAME, AGE)
--WHO HAVE A ,EDICAL HISTORY BUt HAVE NEVER ATTENDED AND APPOINTMENT
--ARE OVER 60 YEARS OLD, LIVE IN ALICANTE (CITY) AND ARE MALE.
SELECT IdHistory, concat (Name, Surnames) as Patients, DATEDIFF(day, DateBirth, GETDATE())/365  as Age
FROM HISTORY, PATIENT
WHERE PATIENT.SIP = HISTORY.SIP
	and city like '%ALICANTE%'
	and gender = 'H'
	and DATEDIFF(day, DateBirth, GETDATE())/365 >= 60
	and idhistory not in 
	(select idhistory
	from LINE_HISTORY)

-- 04 display the patients who have received the sames vaccines,
--hace the same allergies and live in the provinde as VISCTORIA RUIS RAMIREZ
--display only those whose age are between 20 and 25 years old
--sort the result-set by age from youngest to oldest
SELECT PATIENT.SIP, concat (Name, Surnames) as Patients, DATEDIFF(day, DateBirth, GETDATE())/365  as Age, Province, City
FROM HISTORY, PATIENT
WHERE PATIENT.SIP=HISTORY.SIP
and DATEDIFF (day,DateBirth, GETDATE())/365>=20
and DATEDIFF (day,DateBirth, GETDATE())/365>=25
and Vaccines = ()

--Display the nurse who has worked more shifts than any of her colleagues
--in the same area. Sort the result-set by Type
SELECT Name, Surnames, E1.IdArea, Type, COUNT (*) as Total_Shifts
FROM NURSE, EMPLOYEE as E1, Designated, AREA
WHERE NURSE.LicenseNumber=E1.LicenseNumber
	and DESIGNATED.LicenseNumber=E1.LicenseNumber
	and E1.IdArea=AREA.IdArea
GROUP BY Name, Surnames, E1.IdArea, Type
HAVING COUNT (*) >= all
	(select COUNT (*)
	from DESIGNATED, EMPLOYEE as E2
	where DESIGNATED.LicenseNumber=E2.LicenseNumber
		and E1.IdArea=E2.IdArea
	group by E2.LicenseNumber)
ORDER BY Type