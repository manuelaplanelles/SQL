---EJERCICIOS TIPO EXAMEN
--Ejercicio 197
SELECT name, 
    (SELECT COUNT(customer_id) 
     FROM orders 
     WHERE salesman.salesman_id = orders.salesman_id) AS T_Clientes,
    (SELECT SUM(purch_amt) 
     FROM orders 
     WHERE salesman.salesman_id = orders.salesman_id) AS T_Dinero
FROM salesman;

--Ejercicio 201
SELECT salesman.salesman_id, name, SUM(purch_amt) AS T_Purch_amt
FROM salesman, orders
WHERE salesman.salesman_id = orders.salesman_id
GROUP BY salesman.salesman_id, name
HAVING SUM(purch_amt) > (SELECT SUM(purch_amt)
                         FROM salesman, orders
                         WHERE salesman.salesman_id = orders.salesman_id
                         AND name = 'Lauson Hen');
--Ejercicio 202
SELECT customer_id, SUM(purch_amt)
FROM orders
WHERE Order_date BETWEEN '01/10/2012' AND '31/10/2012'
GROUP BY customer_id
HAVING SUM(purch_amt) > (SELECT AVG(purch_amt) FROM orders WHERE DATEPART(yy, Order_date) = 2012);
--Ejercicio 205
--Ejercicio 206
--Ejercicio 207
--Ejercicio 208
--Ejercicio 209
--Ejercicio 217
--Ejercicio 220
--Ejercicio 221
--Ejercicio 222
--Ejercicio 223
--Ejercicio 226
--Ejercicio 232
--Ejercicio 236
--Ejercicio 239
--Ejercicio 240
--Ejercicio 241