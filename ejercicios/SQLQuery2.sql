--primero creas la tabla
--despues hacer la consulta
--y por ultimo el insert

---NATURAL_DISASTER_AID
--1. Create the table DISTRIBUTED_STADISTICS. Insert the total resources distributed to disaster beneficiaries.
create table DISTRIBUTED_STADISTICS
(TypeResource varchar(40)not null
,TotalDistribuited decimal (6,2) not null
,TypeQty varchar (5)not null
)
insert into DISTRIBUTED_STADISTICS
select TypeRes, SUM(Quantity), DISTRIBUTION.TypeQty
from RESOURCES, DISTRIBUTION
where RESOURCES.IdRes=DISTRIBUTION.IdRes
group by TypeRes,DISTRIBUTION.TypeQty

select * from DISTRIBUTED_STADISTICS

-- Create the table BENEFICIARY_STADISTICS. Insert the total resources distributed to beneficiaries who are older than 60 years.
create table BENEFICIARY_STADISTICS
(NameBeneficiciary varchar (50) not null
,Age tinyint not null
,TypeResource varchar(40) not null
,TotalRes smallint not null
,TypeQy varchar (5) not null
)

insert into BENEFICIARY_STADISTICS
select NameBene, DATEDIFF(day, DateOfBirth, GETDATE())/365 as Age, TypeRes,Sum(Quantity) as TotalRes, DISTRIBUTION.TypeQty
from BENEFICIARY, DISTRIBUTION, RESOURCES
where BENEFICIARY.IdBene=DISTRIBUTION.IdBene
and DISTRIBUTION.IdRes=RESOURCES.IdRes
group by NameBene, DATEDIFF(day, DateOfBirth, GETDATE())/365, TypeRes, DISTRIBUTION.TypeQty
having DATEDIFF(day, DateOfBirth, GETDATE())/365 > 60

--3.Create the table DONOR_STADISTICS. Insert the total amount of money and the average for every donor.
create table DONOR_STADISTICS (
DonorID int
,NameDonor varchar (100)
,Totalamount money
,AvgAmount money
)

insert into DONOR_STADISTICS
select DONOR.DonorID, CONCAT(NameDonor, '(', TypeDonor, ')' ) , SUM(Amount) AS Totalamount, CAST(AVG(Amount) as decimal(6,2))
from DONOR, DONATION
where DONOR.DonorID=DONATION.DonorID
group by DONOR.DonorID, NameDonor,TypeDonor

select*from DONOR_STADISTICS

--4.Create the table SUMMARY_PROJECT. Insert the total hours that the volunteer worked and the total volunteers for every project.
CREATE TABLE SUMMARY_PROJECT (
Disaster varchar(65)
,NameProject VARCHAR(100) NOT NULL
,TotalHours DECIMAL(5,1) NOT NULL
,TotalVolunteers smallint NOT NULL
)
INSERT INTO SUMMARY_PROJECT

SELECT CONCAT (TypeDisaster, '-', LocationDis) as Disaster, NameProject, SUM(HoursWork) AS TotalHours, 
	COUNT(VOLUNTEER_HOURS.NumVol) AS TotalVolunteers
FROM RELIEF_PROJECT, VOLUNTEER_HOURS, DISASTER
WHERE RELIEF_PROJECT.IdProject = VOLUNTEER_HOURS.IdProject
and RELIEF_PROJECT.IdDisaster=DISASTER.IdDisaster
GROUP BY NameProject, TypeDisaster, LocationDis
order by TypeDisaster, LocationDis

SELECT * FROM SUMMARY_PROJECT

--5.VOLUNTEERS_INCENTIVE. Insert the money given to the volunteers depending on the hours working. 
--If the volunteer worked more or equal as 90 hours, 100€, if the volunteer worked more or equal as 60 hours, 70€, 
--if the volunteer worked more or equal as 10 hours, 30€, in other cases, 0€.

CREATE TABLE VOLUNTEERS_INCENTIVE (
NameVol VARCHAR(50) NOT NULL
,TotalHours DECIMAL(5,1) NOT NULL
,Incentive MONEY NOT NULL
)
INSERT INTO VOLUNTEERS_INCENTIVE
SELECT NameVol, SUM(HoursWork) ,
     CASE  WHEN SUM(HoursWork) >= 90 THEN 100
           WHEN SUM(HoursWork) >= 60 THEN 70
           WHEN SUM(HoursWork) >= 10 THEN 30
           ELSE 0 END 
FROM VOLUNTEER, VOLUNTEER_HOURS
WHERE VOLUNTEER.NumVol = VOLUNTEER_HOURS.NumVol
GROUP BY NameVol

SELECT * FROM VOLUNTEERS_INCENTIVE

--6.DONATIONS_EXPENSES. Create a table to calculate the total donations and total expenses for every relief center.
CREATE TABLE DONATIONS_EXPENSES (
    NameCenter VARCHAR(100) NOT NULL,
    TotalDonations MONEY NOT NULL,
    TotalExpenses MONEY NOT NULL
)

INSERT INTO DONATIONS_EXPENSES
SELECT NameCenter, SUM(Amount) AS TotalDonations,
       (SELECT SUM(Quantity * UnitPrice * (1 - Discount / 100))
        FROM ORDERS, ORDERS_DETAILS
        WHERE ORDERS.IdOrder = ORDERS_DETAILS.IdOrder
          AND ORDERS.CenterId = R1.CenterId
       ) AS TotalExpenses
FROM RELIEF_CENTER AS R1, DONATION
WHERE R1.CenterId = DONATION.CenterId
GROUP BY R1.CenterId, NameCenter

SELECT * FROM DONATIONS_EXPENSES

--7. DISASTER_ BENEFICIARY_VOLUNTEER. Create a table to calculate the total beneficiaries and volunteers for every disaster.
CREATE TABLE DISASTER_BENEFICIARY_VOLUNTEER (
    TypeDisaster VARCHAR(10) NOT NULL,
    LocationDis VARCHAR(50) NOT NULL,
    Severity VARCHAR(8) NOT NULL,
    T_Beneficiaries smallint NOT NULL,
    T_Volunteers smallint NOT NULL
)
INSERT INTO DISASTER_BENEFICIARY_VOLUNTEER

SELECT DISASTER.TypeDisaster, DISASTER.LocationDis,DISASTER.Severity,
    COUNT(DISTINCT BENEFICIARY.IdBene) AS T_Beneficiaries,
    COUNT(DISTINCT VOLUNTEER_HOURS.NumVol) AS T_Volunteers
FROM DISASTER
LEFT JOIN BENEFICIARY ON DISASTER.IdDisaster = BENEFICIARY.IdDisaster
LEFT JOIN RELIEF_PROJECT ON DISASTER.IdDisaster = RELIEF_PROJECT.IdDisaster
LEFT JOIN VOLUNTEER_HOURS ON RELIEF_PROJECT.IdProject = VOLUNTEER_HOURS.IdProject
GROUP BY DISASTER.TypeDisaster, DISASTER.LocationDis, DISASTER.Severity

SELECT * FROM DISASTER_BENEFICIARY_VOLUNTEER

--8. BEST_STUDENTS_2023. Every year, the Mutxamel Town Hall awards monetary prizes to the best academic records. 
--Create a table to display the 3 award winners along with their grade point averages. Only students who have 
--passed all their subjects on the first attempt are eligible for the prize. You need to use the function ROW_NUMBER().
CREATE TABLE BEST_STUDENTS_2023 (
    DNI VARCHAR(20) NOT NULL,
    NameStudent VARCHAR(50) NOT NULL,
    Surname1 VARCHAR(50) NOT NULL,
    Surname2 VARCHAR(50) NOT NULL,
    FinalMark DECIMAL(4,2) NOT NULL,
    Position VARCHAR(20) NOT NULL
)
INSERT INTO BEST_STUDENTS_2023
SELECT DNI, NameStudent, Surname1,Surname2, FinalMark,
    CASE 
        WHEN RowNum = 1 THEN 'FIRST POSITION'
        WHEN RowNum = 2 THEN 'SECOND POSITION'
        WHEN RowNum = 3 THEN 'THIRD POSITION'
    END AS Position
FROM (SELECT STUDENT.DNI, STUDENT.NameStudent, STUDENT.Surname1, STUDENT.Surname2,
        CAST(AVG(CAST(STUDENT_SUBJECT.Mark AS DECIMAL(4,2))) AS DECIMAL(4,2)) AS FinalMark,
        ROW_NUMBER() OVER (ORDER BY AVG(CAST(STUDENT_SUBJECT.Mark AS DECIMAL(4,2))) DESC) AS RowNum
    FROM STUDENT
        JOIN STUDENT_SUBJECT ON STUDENT.DNI = STUDENT_SUBJECT.DNIStudent
    WHERE STUDENT.DNI NOT IN ( SELECT DNIStudent FROM STUDENT_SUBJECT WHERE Mark < 5)
    GROUP BY STUDENT.DNI, STUDENT.NameStudent, STUDENT.Surname1, STUDENT.Surname2) AS EligibleStudents
WHERE RowNum <= 3

SELECT * FROM BEST_STUDENTS_2023

--9. SUBJECT_STADISTICS. Create a table to calculate the total student and the average mark for every year.
CREATE TABLE SUBJECT_STADISTICS (
    YearCourse TINYINT NOT NULL,
    TotalStudents INT NOT NULL,
    AvgMark DECIMAL(4,2) NOT NULL
)
INSERT INTO SUBJECT_STADISTICS
SELECT YearCourse, COUNT(DISTINCT DNIStudent) AS TotalStudents, 
    CAST(AVG(CAST(Mark AS DECIMAL(4,2))) AS DECIMAL(4,2)) AS AvgMark
FROM STUDENT_SUBJECT
GROUP BY YearCourse

SELECT * FROM SUBJECT_STADISTICS

--10. Update the salary up to 10% more of the employees in departments where the average salary is less than 2000€.
BEGIN TRAMSACTION
SELECTR*FROM EMPLOYEE
UPDATE EMPLOYEE
SET salary=salary+salary*0.1
where deoartmentid in
(select depart
from
group by
having 

--11. Update the prices of products using the inflation rate for the year 2024 from the country of origin of each product. Update only those whose rate exceeds 5%.
begin transaction
select * from product
UPDATE PRODUCT
SET UnitPrice = UnitPrice * (1 + Rate)
FROM PRODUCT, SUPPLIER, COUNTRY,INFLATION
WHERE PRODUCT.SupplierID=SUPPLIER.SupplierID
and SUPPLIER.CountryName=COUNTRY.CountryName
and COUNTRY.CountryName=INFLATION.CountryName
and YearInf=2024
and rate>0.05
select*from product
rollback transaction  

--12. Update the status of ORDERS: if the order was placed more than a year ago, the status will be 'Archived'; 
--if the total of the order exceeds 1000€, the status will be 'Priority'; otherwise, it will be 'Regular'.
BEGIN TRANSACTION
SELECT * FROM ORDERS
UPDATE ORDERS
SET Status = CASE 
    WHEN DATEDIFF(DAY, OrderDate, GETDATE()) > 365 THEN 'Archived'
        WHEN (OrderID in 
            (SELECT ORDERS.OrderID 
              FROM ORDER_DETAILS, ORDERS
              WHERE ORDER_DETAILS.OrderID = ORDERS.OrderID
              group by ORDERS.OrderID
              having SUM(UnitPrice * Quantity * (1 - Discount)) > 1000)) 
           THEN 'Priority'
        ELSE 'Regular' 
        END
SELECT OrderID, OrderDate, Status
FROM ORDERS
ROLLBACK TRANSACTION

--13. Add the prefix 'VIP-' to the company names of customers who have more than 10 completed orders (i.e., orders that have already been received).
BEGIN TRANSACTION
SELECT CustomerID,CompanyName
FROM CUSTOMER
UPDATE CUSTOMER
SET CompanyName = concat ('VIP-', + CompanyName)
WHERE CustomerID IN 
    (SELECT CustomerID
    FROM ORDERS
    WHERE ShippedDate IS NOT NULL
    GROUP BY CustomerID
    HAVING COUNT(OrderID) > 10)
SELECT CustomerID, CompanyName
FROM CUSTOMER
ROLLBACK TRANSACTION

-- 14.Mark as inactive all customers who have not made any orders in the last year.
-- 15. Increase the salary by 10% for those employees whose sales have exceeded 50000€.

-- 16. Decrease the price by 20% for products that have sold less than 50 units in the last 6 months.