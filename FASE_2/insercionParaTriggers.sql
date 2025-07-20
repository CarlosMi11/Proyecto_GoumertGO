-- YO NO HE PROBADO ESTO PUEDE O NO FUNCIONAR DENME CHANC
-- Insercion de 30% de clientes para trigger de referidos
INSERT INTO Cliente(id,[password],telefono,fecha_registro,correo,nombre,apellido,fecha_nac,nro_documento)
VALUES
(71, 'claveSegura71', '555-1071', '2020-05-01', 'cliente71@email.com', 'Sara', 'Robles', '1988-09-15', 10000071),
(72, 'claveSegura72', '555-1072', '2020-05-02', 'cliente72@email.com', 'Roberto', 'Mora', '1977-03-28', 10000072),
(73, 'claveSegura73', '555-1073', '2020-05-03', 'cliente73@email.com', 'Tania', 'Valero', '1993-07-11', 10000073),
(74, 'claveSegura74', '555-1074', '2020-05-04', 'cliente74@email.com', 'Andrés', 'Crespo', '1980-11-24', 10000074),
(75, 'claveSegura75', '555-1075', '2020-05-05', 'cliente75@email.com', 'Mónica', 'Franco', '1996-04-07', 10000075),
(76, 'claveSegura76', '555-1076', '2020-05-06', 'cliente76@email.com', 'Hugo', 'Bernal', '1983-08-20', 10000076),
(77, 'claveSegura77', '555-1077', '2020-05-07', 'cliente77@email.com', 'Nerea', 'Rey', '1979-12-03', 10000077),
(78, 'claveSegura78', '555-1078', '2020-05-08', 'cliente78@email.com', 'Jaime', 'Arias', '1994-02-16', 10000078),
(79, 'claveSegura79', '555-1079', '2020-05-09', 'cliente79@email.com', 'Celia', 'Paz', '1987-06-29', 10000079),
(80, 'claveSegura80', '555-1080', '2020-05-10', 'cliente80@email.com', 'Diego', 'Carmona', '1975-10-12', 10000080),
(81, 'claveSegura81', '555-1081', '2020-05-11', 'cliente81@email.com', 'Luis', 'Molina', '1990-03-25', 10000081),
(82, 'claveSegura82', '555-1082', '2020-05-12', 'cliente82@email.com', 'Marta', 'Castaño', '1985-07-08', 10000082),
(83, 'claveSegura83', '555-1083', '2020-05-13', 'cliente83@email.com', 'Joaquín', 'Salas', '1998-01-21', 10000083),
(84, 'claveSegura84', '555-1084', '2020-05-14', 'cliente84@email.com', 'Aitana', 'Varela', '1982-04-04', 10000084),
(85, 'claveSegura85', '555-1085', '2020-05-15', 'cliente85@email.com', 'Oliver', 'Ramos', '1976-08-17', 10000085),
(86, 'claveSegura86', '555-1086', '2020-05-16', 'cliente86@email.com', 'Yolanda', 'Luque', '1993-12-30', 10000086),
(87, 'claveSegura87', '555-1087', '2020-05-17', 'cliente87@email.com', 'Simón', 'Roldán', '1989-05-13', 10000087),
(88, 'claveSegura88', '555-1088', '2020-05-18', 'cliente88@email.com', 'Nicolás', 'Quintero', '1978-09-26', 10000088),
(89, 'claveSegura89', '555-1089', '2020-05-19', 'cliente89@email.com', 'Aroa', 'Plaza', '1995-02-08', 10000089),
(90, 'claveSegura90', '555-1090', '2020-05-20', 'cliente90@email.com', 'Eric', 'Acosta', '1981-06-21', 10000090),
(91, 'claveSegura91', '555-1091', '2020-06-01', 'cliente91@email.com', 'Mariano', 'Corral', '1997-10-04', 10000091),
(92, 'claveSegura92', '555-1092', '2020-06-02', 'cliente92@email.com', 'Irene', 'Rosado', '1984-01-17', 10000092),
(93, 'claveSegura93', '555-1093', '2020-06-03', 'cliente93@email.com', 'Salvador', 'Saiz', '1979-05-30', 10000093),
(94, 'claveSegura94', '555-1094', '2020-06-04', 'cliente94@email.com', 'Lara', 'Perea', '1996-09-12', 10000094),
(95, 'claveSegura95', '555-1095', '2020-06-05', 'cliente95@email.com', 'Fermín', 'Bermúdez', '1983-12-25', 10000095),
(96, 'claveSegura96', '555-1096', '2020-06-06', 'cliente96@email.com', 'Amparo', 'Villanueva', '1977-04-08', 10000096),
(97, 'claveSegura97', '555-1097', '2020-06-07', 'cliente97@email.com', 'Rodrigo', 'Roca', '1994-08-21', 10000097),
(98, 'claveSegura98', '555-1098', '2020-06-08', 'cliente98@email.com', 'Esperanza', 'Galán', '1980-11-03', 10000098),
(99, 'claveSegura99', '555-1099', '2020-06-09', 'cliente99@email.com', 'Teodoro', 'Vaquero', '1991-03-16', 10000099),
(100, 'claveSegura100', '555-1100', '2020-06-10', 'cliente100@email.com', 'Bea', 'Belisario', '1986-07-29', 10000100);

-- Inserts para activar trigger de factura
INSERT INTO Pedido(id,cantidad_items,costo_envio,nota,tiempo_entrega,total)
VALUES
(141, 1, 1.50, 'Sin sésamo', 50, 55.30),
(142, 3, 2.50, 'Entregar en piso ejecutivo', 85, 84.70),
(143, 4, 2.75, 'Empaque hermético', 90, 98.20),
(144, 2, 2.00, 'Sin alérgenos', 70, 76.80),
(145, 1, 1.50, 'Boda de oro', 55, 60.40),
(146, 5, 3.00, 'Empaque corporativo', 90, 108.70),
(147, 3, 2.50, 'Dejar con anfitrión', 80, 85.20),
(148, 2, 2.00, 'Extra limón', 70, 75.60),
(149, 4, 2.75, 'Para banquete', 95, 104.80),
(150, 1, 1.50, 'Sin gluten', 50, 58.20);

-- Updates de pedido estado para activar trigger de entrega
UPDATE PedidoEstadoPedido
SET idEstadoPedido = 6
WHERE id = 11

UPDATE PedidoEstadoPedido
SET idEstadoPedido = 6
WHERE id = 13

-- Delete para trigger de devoluciones
DELETE FROM PedidoDetalle WHERE id = 47;
DELETE FROM PedidoDetalle WHERE id = 50;

-- Insert para trigger de opciones
INSERT INTO PedidoDetalle (id, cantidad, nota, total, idPedido, idPlato) 
VALUES
(47, 1, 'Con hielo', 5.00, 82, 87);

-- Insert para trigger de cantidad
INSERT INTO PedidoDetalle (id, cantidad, nota, total, idPedido, idPlato) 
VALUES
(50, 10, 'Con vinagreta aparte', 11.50, 120, 106); -- Deberia decir que no hay suficiente