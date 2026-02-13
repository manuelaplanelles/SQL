--VICTORIA hOSPITAL.
--01.Display the nurse who has worked more shifts than any of her colleagues in the same area. Sort the resultset by Type.
SELECT Name, Surnames, AREA.IdArea, Type as TypeArea, COUNT (SHIFT.IdShift) as Total_Shifts
FROM AREA, EMPLOYEE, DESIGNATED, SHIFT
WHERE AREA.IdArea=EMPLOYEE.IdArea
	and EMPLOYEE.LicenseNumber=DESIGNATED.LicenseNumber
	and DESIGNATED.IdShift=SHIFT.IdShift
GROUP BY Name, Surnames, AREA.IdArea, Type, SHIFT.IdShift
HAVING COUNT(SHIFT.IdShift)>=all
		(select COUNT (DESIGNATED.IdShift) as Total_Shifts
		from EMPLOYEE, DESIGNATED
		where EMPLOYEE.LicenseNumber=DESIGNATED.LicenseNumber
		group by EMPLOYEE.LicenseNumber)
ORDER BY Type

--02.Display the total number of appointments for every doctor.
SELECT Name, Surnames, COUNT(*) as TotalAppointments
FROM LINE_HISTORY, DOCTOR, EMPLOYEE
WHERE LINE_HISTORY.LicenseNumber=DOCTOR.LicenseNumber
	and DOCTOR.LicenseNumber=EMPLOYEE.LicenseNumber
GROUP BY Name, Surnames

--03.Display patients who are allergic to the SULFAMIDAS, live in Madrid or Alicante province and have a history but never 
--had an appointment (LINE_HISTORY)
SELECT PATIENT.SIP, Name, Surnames, BloodType
FROM LINE_HISTORY, HISTORY, PATIENT
WHERE LINE_HISTORY.IdHistory=HISTORY.IdHistory
	and HISTORY.SIP=PATIENT.SIP
	and Allergies = 'SULFAMIDAS'
	and Province = 'Madrid' or Province = 'Alicante'
	and LINE_HISTORY.IdHistory not in
		(select IdHistory
		from LINE_HISTORY)
ORDER BY Allergies

--04.Display Rooms that have never been used for admissions.
--05.Display doctors who are 'Cirujano, had appointments but never performed an operation.
--06.Display the tests that cost more than the average cost of all the tests.
--07.Display the patients who have a medical history but have never attended any appointment, are over 60 years old, live 
--in Alicante, and are male.
--08.Display the patients who have received the same vaccines, have the same allergies, and live in the same province as 
--VICTORIA RUIZ RAMIREZ. Show only those whose ages are between 20 and 25 years. Sort the result by age from youngest to oldest.

--GARDENING - SUBQUERIES.
--182.Write a SQL query to count the total amount of orders and clients for every employee.
--183.Write a SQL query to create a comparative analysis for the years 2008 and 2009.

--SALES-ORDERS.
--197.Write a SQL query to calculate the total customers and total purchase amount for every salesman.

--EXPERT-LOGISTICS.
--217.Write a SQL query to calculate the total amount for every bill of every client in 1996 and 1997.
--220.Suppose you want a report of all OrderID's where the customer did not purchase more than 10% of the average quantity sold for a given product. Write a SQL query to find the orders, customers, and products. Sort the result-set in alphabetical order by CompanyName
--223.The company wants to run a yearlong incentive program to increase revenue. Therefore, they advertise to the customers that if each order they place, during the year 1997, is over 750€ the company will provide them a rebate at the end of the year at the rate of 75€ per order they place the customers. Write a SQL query to calculate the rebate amount.
--224.The company wants to motivate the employees to try to sell as much as possible by giving them a commission of 50€ for every order bigger than 3000€. Write a SQL query to calculate the commission for every employee in 1996. Sort the result-set in ascending order by commission.

--LUNAR_PUBLISHERS.
--232.Write a SQL query to find the stores which sold more than 50 units in 1993. They will be provided by a rebate at the end of the year at the rate of 10€ per order they place the stores. Display the stor_id, the stor_name and calculate the rebate amount.

--HOSPITAL
--272.Write a SQL query to show the physicians and the total number of appointments. Display the physicians who did not have appointments as well.
--273.Write a SQL query count the treatments who were performed by their PCP of every patient.

--MEGASUR DISTRIBUTOR
--279.Write a SQL query to find the items which were sold by more than one supplier or were sold with a cheaper price than were bought.