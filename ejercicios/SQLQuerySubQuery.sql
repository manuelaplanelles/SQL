--display the clients from th same as Beragua
SELECT name_client
FROM client
where city = 
	(SELECT City
	FROM client
	WHERE Name_client = 'Beragua')

--display the plants which are the same range as Melissa
SELECT Name
FROM product
WHERE Range = 
	(Select Range
	From product
	Where Name = 'Melissa')
AND Name != 'Melissa'  -- para quitar de la lista a Melissa

--display the employees who have the same boss as Mariano Lopez
SELECT Name, Surname1
FROM employee
WHERE Code_boss =
	(select Code_boss
	from employee
	where Name = 'Mariano' and Surname1 = 'López')
AND Name != 'Mariano' and Surname1 != 'López' -- para quitar de la lista a Melissa

--display the clients who bought the same products as Tendo Garden
--bought in 2006
select Name_client
from client, orders, order_detail
where cliente.code_cliente=orders.Code_client
	and order.Code_order=order_detail.Code_order 
	and code_product in
		(select Code_product
		from client, orders, order_detail
		where cliente.code_cliente=orders.Code_client
			and order.Code_order=order_detail.Code_order 
			and year(order_date) = '2006'
			and name_client='Tendo Garden')
	and name_client != 'Tendo Garden'