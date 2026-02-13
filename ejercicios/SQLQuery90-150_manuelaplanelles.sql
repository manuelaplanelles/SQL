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

--EXERCISE 124 --dudas
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

--EXERCISE 140 --dudas
SELECT CONCAT (Name + ' ' + Surname1 + ' ' + ISNULL(Surname2, '') AS EMPLOYEE
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