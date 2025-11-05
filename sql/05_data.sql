USE ex2;

SET NAMES 'utf8mb4';

INSERT INTO province (name) VALUES
('Madrid'),
('Barcelona'),
('Valencia');

INSERT INTO town (name, province_id) VALUES
('Centro', 1),
('Salamanca', 1),
('Eixample', 2),
('Gracia', 2),
('Ruzafa', 3);

INSERT INTO shop (address, postal_code, town_id) VALUES
('Calle Mayor 1', '28013', 1),
('Calle Alcala 45', '28014', 2),
('Passeig de Gracia 10', '08007', 3);

INSERT INTO employee (first_name, last_name, NIF, phone, role, shop_id) VALUES
('Carlos', 'Gómez', '12345678A', '600111222', 'cook', 1),
('Laura', 'Martínez', '23456789B', '600333444', 'delivery', 1),
('Ana', 'Sánchez', '34567890C', '600555666', 'cook', 2),
('Miguel', 'López', '45678901D', '600777888', 'delivery', 3);

INSERT INTO customer (first_name, last_name, address, postal_code, phone_number, town_id) VALUES
('María', 'López', 'Calle Gran Via 15', '28013', '611223344', 1),
('José', 'Pérez', 'Calle Balmes 20', '08007', '622334455', 3),
('Lucía', 'García', 'Calle Ruzafa 5', '46004', '633445566', 5);

INSERT INTO category (name) VALUES
('Margherita'),
('Pepperoni'),
('Hawaiana');

INSERT INTO product (name, description, price, image_url, product_type, category_id) VALUES
('Margherita', 'Pizza con tomate y mozzarella', 8.50, '', 'pizza', 1),
('Pepperoni', 'Pizza con pepperoni', 9.50, '', 'pizza', 2),
('Hawaiana', 'Pizza con jamón y piña', 10.00, '', 'pizza', 3),
('Cheeseburger', 'Hamburguesa con queso', 6.00, '', 'burger', NULL),
('Veggie Burger', 'Hamburguesa vegetariana', 6.50, '', 'burger', NULL),
('Coca-Cola', 'Refresco de cola', 1.50, '', 'drink', NULL),
('Water', 'Agua mineral', 1.00, '', 'drink', NULL);

INSERT INTO `order` (datetime, delivery_type, total_price, employee_id, shop_id, customer_id, delivery_datetime) VALUES
('2025-01-10 12:30:00', 'delivery', 18.50, 2, 1, 1, '2025-01-10 13:00:00'),
('2025-01-11 19:00:00', 'pickup', 7.50, 4, 3, 2, NULL),
('2025-01-12 13:15:00', 'delivery', 9.50, 2, 1, 3, '2025-01-12 13:45:00');

INSERT INTO order_detail (quantity, order_id, product_id) VALUES
(1, 1, 1),
(1, 1, 2),
(1, 2, 4),
(2, 3, 7);