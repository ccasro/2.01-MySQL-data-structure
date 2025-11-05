use ex1;
-- Lists the total invoices of a customer in a given period.
SELECT
	c.name AS client_name,
    COUNT(s.id) AS total_invoices
FROM sale s
JOIN client c ON s.client_id  = c.id
WHERE c.name = 'María López'
 AND s.sale_date BETWEEN '2024-01-01' AND '2024-03-31'
 GROUP BY c.name;

-- Lists the different models of glasses that an employee has sold during a year.
SELECT
    e.name AS employee_name,
    g.brand AS glasses_model,
    COUNT(s.id) AS total_sold
FROM sale s
JOIN employee e ON s.employee_id = e.id
JOIN glasses g ON s.glasses_id = g.id
WHERE e.name = 'Carlos Gómez'
  AND YEAR(s.sale_date) = 2024
GROUP BY e.name, g.brand
ORDER BY g.brand;

-- Lists the different suppliers that have supplied glasses that have been successfully sold by the optician.
SELECT DISTINCT
	p.name AS provider_name
    FROM provider p
JOIN glasses g ON g.provider_id = p.id
JOIN sale s ON s.glasses_id = g.id
ORDER by p.name;

use ex2;

-- Lists how many products of the 'Beverages' category have been sold in a given location.
SELECT pr.name AS locality, SUM(od.quantity) AS total_products_sold
FROM order_detail od
JOIN product p ON od.product_id = p.id
JOIN `order` o ON od.order_id = o.id
JOIN shop s ON o.shop_id = s.id
JOIN town t ON s.town_id = t.id
JOIN province pr ON t.province_id = pr.id
WHERE p.product_type = 'drink'
  AND pr.name = 'Madrid'
GROUP BY pr.name;

-- Lists how many orders a given employee has placed.
SELECT e.first_name employee_name, count(*) AS total_orders
FROM `order` o
JOIN employee e ON o.employee_id = e.id
GROUP BY e.first_name;
