USE ex1;
SET NAMES 'utf8mb4';

INSERT INTO employee (name) VALUES
('Laura Martínez'),
('Carlos Gómez'),
('Ana Torres'),
('David Pérez');


INSERT INTO provider (name, phone, fax, tax_id) VALUES
('OptiGlass S.A.', '+34 912345678', '+34 912345679', 'A12345678'),
('VisionTech Ltd.', '+44 207123456', NULL, 'B87654321'),
('ClearView Corp.', '+1 2025550182', '+1 2025550183', 'C23456789');


INSERT INTO address (street, street_number, postal_code, city, country) VALUES
('Calle Mayor', '12', '28013', 'Madrid', 'España'),
('Gran Vía', '45', '28010', 'Madrid', 'España'),
('Oxford Street', '220', 'W1D 1NN', 'Londres', 'Reino Unido'),
('5th Avenue', '789', '10022', 'Nueva York', 'EE.UU.'),
('Passeig de Gràcia', '92', '08008', 'Barcelona', 'España');


INSERT INTO provider_has_address (address_id, provider_id) VALUES
(1, 1),
(3, 2),
(4, 3);


INSERT INTO client (name, address, phone, email, registered_at, referred_by_client_id) VALUES
('María López', 'Calle Alcalá 23, Madrid', '+34 600111222', 'maria@example.com', '2024-01-15', NULL),
('José Ruiz', 'Av. Diagonal 77, Barcelona', '+34 600333444', 'jose@example.com', '2024-02-10', 1),
('Lucía Fernández', 'Calle Serrano 8, Madrid', '+34 600555666', 'lucia@example.com', '2024-03-05', 2),
('Miguel Ángel', 'Calle Real 9, Sevilla', '+34 600777888', 'miguel@example.com', '2024-03-20', 1);


INSERT INTO client_has_address (address_id, client_id) VALUES
(1, 1),
(2, 2),
(5, 3),
(1, 4);


INSERT INTO glasses (provider_id, brand, lens_power, frame_type, frame_color, lens_color, price) VALUES
(1, 'Ray-Ban', 1.50, 'metal', 'Negro', 'Transparente', 120.00),
(1, 'Oakley', 2.00, 'plastic', 'Azul', 'Gris', 140.50),
(2, 'Gucci', 1.75, 'floating', 'Dorado', 'Marrón', 250.00),
(3, 'Versace', 0.00, 'metal', 'Plateado', 'Verde', 300.00),
(3, 'Prada', 1.25, 'plastic', 'Rojo', 'Transparente', 180.00);


INSERT INTO sale (sale_date, glasses_id, client_id, employee_id) VALUES
('2024-03-21 10:15:00', 1, 1, 1),
('2024-03-25 12:30:00', 2, 2, 2),
('2024-04-02 17:00:00', 3, 3, 3),
('2024-04-10 09:45:00', 4, 4, 2),
('2024-04-12 16:10:00', 5, 1, 4);