/*Comercio
Cocina
ComercioCocina
Menu
Seccion
Plato
PlatoOpcion
PlatoOpcionValor
Opcion
OpcionValor
Cliente
ClienteConClienteReferido
Direccion
DireccionCliente
ClienteRepartidor
Repartidor
nro_documento, detalle_vehiculo, estado)
Factura
Pedido
ClientePedido
RepartidorPedido
PedidoDetalle
PedidoDetalleOpcionValor
EstadoPedido
PedidoEstadoPedido*/

-- ELIMINE LAS INSERCIONES DE CLIENTECONCLIENTEREFERIDO YA QUE EL TRIGGER DEBERIA HACERLO AUTOMATICAMENTE
-- TAMBIEN ELIMINE EL 30% DE LOS CLIENTES PARA QUE SE AGREGUEN CON EL OTRO SCRIPT DESPUES DEL TRIGGER
-- ELIMINE TAMBIEN ALGUNOS PEDIDOS PARA ACTIVARLOS CON EL TRIGGER CREO NO SE NO ME ACUERDO UN SALUDO, ANDREA.

INSERT INTO Comercio(id, [password], telefono, fecha_registro, correo, nombre, ubicacion_fisica,hora_apertura, hora_cierre, estaActivo)
VALUES
(1, 'italia123', '212-555-2001', '2018-05-15', 'bellaitalia@email.com', 'Trattoria Bella Italia', 'Av. Principal de La Castellana, Caracas', 12, 23, 1),
(2, 'sushi456', '212-555-2002', '2019-02-20', 'sakura@email.com', 'Sakura Sushi Bar', 'Calle Orinoco, Las Mercedes', 11, 23, 1),
(3, 'mex789', '212-555-2003', '2017-11-10', 'mexican@email.com', 'La Cantina Mexicana', 'Av. Francisco de Miranda, El Rosal', 12, 22, 1),
(4, 'china000', '212-555-2004', '2020-03-05', 'dragón@email.com', 'Restaurante El Dragón', 'Av. Libertador, Chacao', 11, 22, 0), -- Inactivo
(5, 'espana111', '212-555-2005', '2019-07-18', 'paella@email.com', 'Barceloneta', 'Calle California, Las Mercedes', 12, 23, 1),
(6, 'india222', '212-555-2006', '2018-09-22', 'curry@email.com', 'Taj Mahal', 'Av. Río de Janeiro, Plaza Venezuela', 12, 22, 1),
(7, 'peru333', '212-555-2007', '2021-01-15', 'ceviche@email.com', 'El Cevichero', 'CC San Ignacio, Nivel Gastronomía', 12, 22, 1),
(8, 'libanes444', '212-555-2008', '2017-08-30', 'beirut@email.com', 'Al Wadi', 'Av. Andrés Bello, Caracas', 12, 23, 1),
(9, 'arg555', '212-555-2009', '2020-06-12', 'asado@email.com', 'La Parrilla Argentina', 'Calle Madrid, Las Mercedes', 12, 0, 1), -- Abierto hasta medianoche
(10, 'jap666', '212-555-2010', '2019-04-05', 'ramen@email.com', 'Tokyo Ramen', 'CCCT, Nivel Comidas', 12, 22, 1),
(11, 'arepa777', '212-555-2011', '2018-03-15', 'arepera@email.com', 'Arepera La Venezolana', 'Av. Principal de Los Palos Grandes', 7, 22, 1),
(12, 'pab888', '212-555-2012', '2017-12-20', 'pabellon@email.com', 'El Pabellón Criollo', 'Calle Mohedano, El Rosal', 11, 22, 1),
(13, 'hall999', '212-555-2013', '2020-02-18', 'hallaca@email.com', 'Las Hallaquitas', 'Av. Casanova, Sabana Grande', 11, 21, 1),
(14, 'pesc000', '212-555-2014', '2019-08-25', 'pescado@email.com', 'La Casa del Pescado', 'Av. Principal de Macaracuay', 11, 20, 0), -- Inactivo
(15, 'empa111', '212-555-2015', '2018-06-30', 'empanada@email.com', 'Empanadas Doña Juana', 'Calle Villaflor, Chacao', 6, 15, 1),
(16, 'teque222', '212-555-2016', '2021-03-12', 'tequeño@email.com', 'Los Tequeños de María', 'CC Millenium Mall, Food Court', 10, 21, 1),
(17, 'cach333', '212-555-2017', '2017-10-05', 'cachapa@email.com', 'La Cachapera', 'Av. Luis Roche, Altamira', 7, 19, 1),
(18, 'mond444', '212-555-2018', '2020-05-22', 'mondongo@email.com', 'El Mondonguito', 'Av. Urdaneta, Caracas', 11, 21, 1),
(19, 'asbl555', '212-555-2019', '2019-01-15', 'asado@email.com', 'Asado Negro Bar', 'Calle Jalisco, Las Mercedes', 12, 23, 1),
(20, 'sanco666', '212-555-2020', '2018-11-08', 'sancocho@email.com', 'Sancocho Power', 'Av. Principal de La Florida', 11, 20, 1),
(21, 'cafe777', '212-555-2021', '2020-04-10', 'cafearte@email.com', 'Café con Arte', 'Calle Elice, San Bernardino', 7, 21, 1),
(22, 'pan888', '212-555-2022', '2019-07-15', 'panaderia@email.com', 'Panadería Francesa', 'Av. Andrés Bello, Torre La Previsora', 6, 20, 1),
(23, 'choc999', '212-555-2023', '2017-09-20', 'chocolate@email.com', 'Chocolatería Suiza', 'CC Paseo Las Mercedes', 10, 20, 0), -- Inactivo
(24, 'post000', '212-555-2024', '2021-02-05', 'postres@email.com', 'Postres y Tentaciones', 'CC Tolón, Nivel Comidas', 10, 21, 1),
(25, 'taza111', '212-555-2025', '2018-12-12', 'te@email.com', 'La Tetería', 'Calle Los Cedros, Chacao', 9, 20, 1),
(26, 'hamb222', '212-555-2026', '2020-06-18', 'hamburguesa@email.com', 'Burger Master', 'Av. Libertador, Chacaíto', 11, 23, 1),
(27, 'pizza333', '212-555-2027', '2019-03-25', 'pizza@email.com', 'Pizza Napolitana', 'CC Sambil, Food Court', 11, 23, 1),
(28, 'hot444', '212-555-2028', '2017-05-30', 'perro@email.com', 'Hot Dog City', 'Av. Francisco Solano, Sabana Grande', 10, 22, 0), -- Inactivo
(29, 'pollo555', '212-555-2029', '2021-01-08', 'pollo@email.com', 'Pollo a la Brasa', 'Av. Principal de El Hatillo', 11, 22, 1),
(30, 'taco666', '212-555-2030', '2018-10-15', 'taco@email.com', 'Taco Express', 'CC El Recreo, Nivel Comidas', 11, 22, 1),
(31, 'veg777', '212-555-2031', '2020-07-22', 'vegano@email.com', 'Verde Vida Vegano', 'Calle Guaicaipuro, El Rosal', 8, 21, 1),
(32, 'org888', '212-555-2032', '2019-05-15', 'organico@email.com', 'Orgánico Express', 'Av. Principal de Altamira', 9, 20, 1),
(33, 'glut999', '212-555-2033', '2017-04-10', 'gluten@email.com', 'Sin Gluten', 'CC Lider, Local 22', 10, 19, 0), -- Inactivo
(34, 'sushi000', '212-555-2034', '2021-03-30', 'sushi2@email.com', 'Sushi Healthy', 'CC San Ignacio, Nivel Comidas', 12, 22, 1),
(35, 'jugo111', '212-555-2035', '2018-08-12', 'jugos@email.com', 'Jugoterapia', 'Av. Principal de Los Chorros', 7, 19, 1);

INSERT INTO Cocina(id,nombre,descripcion)
VALUES
(1, 'China', 'Especialidades de comida china y oriental.'),
(2, 'Mexicana', 'Tacos, enchiladas y gastronomía mexicana tradicional.'),
(3, 'Italiana', 'Pizzas, pastas y cocina mediterránea italiana.'),
(4, 'Japonesa', 'Sushi, ramen y platos típicos de Japón.'),
(5, 'Hindú', 'Currys, especias y cocina de la India.'),
(6, 'Árabe', 'Comida del Medio Oriente: shawarma, falafel, kebabs.'),
(7, 'Parrilla', 'Carnes a la parrilla, asados y BBQ.'),
(8, 'Venezolana', 'Platos típicos venezolanos: arepas, pabellón, cachapas.'),
(9, 'Mediterránea', 'Gastronomía del Mediterráneo: tapas, ensaladas, mariscos.'),
(10, 'Francesa', 'Alta cocina francesa, quiches, crepes y repostería.'),
(11, 'Española', 'Paellas, tortillas y cocina tradicional de España.'),
(12, 'Peruana', 'Ceviche, causa limeña y gastronomía peruana.'),
(13, 'Brasileña', 'Churrasco, feijoada y platos típicos de Brasil.'),
(14, 'Argentina', 'Cortes de carne, empanadas y parrilladas argentinas.'),
(15, 'Coreana', 'Bibimbap, bulgogi y cocina coreana.'),
(16, 'Tailandesa', 'Curry tailandés, pad thai y sabores picantes.'),
(17, 'Vietnamita', 'Pho, rollitos primavera y cocina de Vietnam.'),
(18, 'Colombiana', 'Bandeja paisa, arepas y gastronomía colombiana.'),
(19, 'Sin Gluten', 'Platos aptos para celíacos.'),
(20, 'Salvadoreña', 'Pupusas, tamales y platos típicos de El Salvador.'),
(21, 'Griega', 'Ensaladas, gyros y gastronomía griega.'),
(22, 'Turca', 'Döner kebab, baklava y cocina turca.'),
(23, 'Alemana', 'Salchichas, schnitzel y cocina alemana.'),
(24, 'Internacional', 'Fusión de platos de diferentes países.'),
(25, 'Tradicional', 'Comida casera y tradicional de la región.'),
(26, 'Gourmet', 'Alta cocina, platos elaborados con técnicas sofisticadas.'),
(27, 'Experimental', 'Cocina creativa con técnicas innovadoras y sabores únicos.'),
(28, 'Fusión', 'Combinación de distintas tradiciones culinarias.'),
(29, 'Orgánica', 'Platos elaborados con ingredientes 100% orgánicos y sostenibles.'),
(30, 'Casera', 'Recetas tradicionales preparadas como en casa.'),
(31, 'Tex-Mex', 'Fusión de sabores mexicanos con cocina del sur de Estados Unidos.'),
(32, 'Street Food', 'Comida callejera internacional, práctica y variada.'),
(33, 'Healthy-Fit', 'Platos saludables, bajos en calorías y balanceados para dieta fitness.'),
(34, 'Comfort Food', 'Comidas reconfortantes y abundantes, típicas del hogar.'),
(35, 'Mar y Tierra', 'Combinación de mariscos y carnes a la parrilla.');

INSERT INTO ComercioCocina(idComercio,idCocina)
VALUES
-- Restaurantes internacionales (IDs 1-10)
(1, 3),  -- Trattoria Bella Napoli (Italiana)
(2, 4),  -- Sakura Sushi Bar (Japonesa)
(3, 2),  -- La Cantina Mexicana (Mexicana)
(4, 1),  -- Restaurante El Dragón (China)
(5, 11), -- Barceloneta (Española)
(6, 5),  -- Taj Mahal (Hindú)
(7, 12), -- El Cevichero (Peruana)
(8, 6),  -- Al Wadi (Árabe)
(9, 14), -- La Parrilla Argentina (Argentina)
(10, 4), -- Tokyo Ramen (Japonesa)
-- Comida venezolana (IDs 11-20)
(11, 8),  -- Arepera La Venezolana (Venezolana)
(12, 8),  -- El Pabellón Criollo (Venezolana)
(13, 8),  -- Las Hallaquitas (Venezolana)
(14, 8),  -- La Casa del Pescado (Venezolana con mariscos)
(15, 8),  -- Empanadas Doña Juana (Venezolana)
(16, 8),  -- Los Tequeños de María (Venezolana)
(17, 8),  -- La Cachapera (Venezolana)
(18, 8),  -- El Mondonguito (Venezolana)
(19, 8),  -- Asado Negro Bar (Venezolana)
(20, 8),  -- Sancocho Power (Venezolana)
-- Cafés y panaderías (IDs 21-25)
(21, 10), -- Café con Arte (Francesa)
(22, 10), -- Panadería Francesa (Francesa)
(23, 10), -- Chocolatería Suiza (Francesa)
(24, 10), -- Postres y Tentaciones (Francesa)
(25, 10), -- La Tetería (Francesa)
-- Comida rápida (IDs 26-30)
(26, 24), -- Burger Master (Internacional)
(27, 3),  -- Pizza Napolitana (Italiana)
(28, 32), -- Hot Dog City (Street Food)
(29, 7),  -- Pollo a la Brasa (Parrilla)
(30, 2),  -- Taco Express (Mexicana)
-- Comida saludable (IDs 31-35)
(31, 29), -- Verde Vida Vegano (Orgánica)
(32, 29), -- Orgánico Express (Orgánica)
(33, 19), -- Sin Gluten (Sin Gluten)
(34, 33), -- Sushi Healthy (Healthy-Fit)
(35, 33),  -- Jugoterapia (Healthy-Fit)
-- Asignación de segundas cocinas para algunos comercios
(1, 9),   -- Italiana + Mediterránea
(2, 28),  -- Japonesa + Fusión
(3, 31),  -- Mexicana + Tex-Mex
(5, 9),   -- Española + Mediterránea
(6, 11),  -- Hindú + Vegetariana
(7, 35),  -- Peruana + Mar y Tierra
(9, 7),   -- Argentina + Parrilla
(14, 35), -- Venezolana + Mar y Tierra
(26, 7),  -- Burger + Parrilla
(29, 8),  -- Pollo a la Brasa + Venezolana
(31, 12), -- Vegano + Peruano
(34, 4);   -- Sushi + Japonesa

INSERT INTO Menu(id,nombre,descripcion,idComercio)
VALUES
(1, 'Menú Degustación Italiano', 'Selección de los mejores platos de la cocina italiana: antipasti, pasta fresca y tiramisú', 1),
(2, 'Menú Sushi Experience', 'Variedad de sushi, sashimi y rolls especiales del chef', 2),
(3, 'Menú Fiesta Mexicana', 'Combinación de tacos, enchiladas y chiles rellenos con guarniciones', 3),
(4, 'Menú Gran Dragón', 'Lo mejor de la cocina china: sopa wantán, cerdo agridulce y rollitos primavera', 4),
(5, 'Menú Paella Completa', 'Auténtica paella valenciana con entremeses españoles', 5),
(6, 'Menú Curry Selection', 'Variedad de curries con arroz basmati y panes indios', 6),
(7, 'Menú Sabores del Perú', 'Ceviche, causa limeña y lomo saltado', 7),
(8, 'Menú Libanés Completo', 'Mezze variado con kebabs y postres árabes', 8),
(9, 'Menú Parrillada Argentina', 'Cortes premium con chimichurri y guarniciones', 9),
(10, 'Menú Ramen Experience', 'Diferentes tipos de ramen con entradas japonesas', 10),
(11, 'Menú Criollo Completo', 'Pabellón, arepa rellena y postre tradicional', 11),
(12, 'Menú Tradiciones Venezolanas', 'Hallaca, pan de jamón y ensalada de gallina', 12),
(13, 'Menú Hallaquitas Especial', 'Variedad de hallaquitas con diferentes rellenos', 13),
(14, 'Menú del Mar Venezolano', 'Pescado frito con tostones y ensalada', 14),
(15, 'Menú de Empanadas', '5 empanadas de diferentes rellenos con salsa picante', 15),
(16, 'Menú Tequeños y Más', 'Tequeños, pastelitos y bebida tradicional', 16),
(17, 'Menú Cachapero', 'Cachapas con queso de mano y diferentes proteínas', 17),
(18, 'Menú Sopas Tradicionales', 'Mondongo, sancocho y sopa de res', 18),
(19, 'Menú Asados Criollos', 'Asado negro, carne mechada y pollo guisado', 19),
(20, 'Menú Sancocho Familiar', 'Sancocho gigante para 4 personas con todos los acompañamientos', 20),
(21, 'Menú Desayuno Completo', 'Café, jugo, arepa o pan y proteína', 21),
(22, 'Menú Merienda Francesa', 'Selección de panes, croissants y pastelería fina', 22),
(23, 'Menú Chocolate Caliente', 'Chocolate especial con acompañamientos dulces', 23),
(24, 'Menú Postres Gourmet', 'Selección de 3 postres pequeños para degustar', 24),
(25, 'Menú Té de la Tarde', 'Variedad de tés con sándwiches y pastelitos', 25),
(26, 'Menú Burger Master', 'Hamburguesa, papas fritas y bebida', 26),
(27, 'Menú Pizza Familiar', 'Pizza grande + 2 acompañamientos + bebidas', 27),
(28, 'Menú Hot Dog Especial', '2 hot dogs gourmet con papas y bebida', 28),
(29, 'Menú Pollo a la Brasa', '1/4 de pollo con ensalada y arepa', 29),
(30, 'Menú Taco Party', '4 tacos diferentes con guacamole y bebida', 30),
(31, 'Menú Vegano Completo', 'Plato principal, sopa y postre 100% vegano', 31),
(32, 'Menú Orgánico', 'Selección de platos con ingredientes orgánicos certificados', 32),
(33, 'Menú Sin Gluten', 'Tres platos sin gluten con postre incluido', 33),
(34, 'Menú Sushi Saludable', 'Rolls de arroz integral con proteínas magras', 34),
(35, 'Menú Detox', 'Jugos naturales, ensalada y sopa depurativa', 35);

INSERT INTO Seccion(id,nombre,descripcion,idMenu)
VALUES
(1, 'Antipasti', 'Selección de entradas frías italianas', 1),
(2, 'Primi Piatti', 'Platos principales de pasta fresca', 1),
(3, 'Secondi Piatti', 'Carnes y pescados a la parrilla', 1),
(4, 'Contorni', 'Guarniciones y acompañamientos', 1),
(5, 'Dolci', 'Postres tradicionales italianos', 1),
(6, 'Sashimi', 'Pescado fresco en cortes perfectos', 2),
(7, 'Nigiri', 'Arroz con pescado fresco encima', 2),
(8, 'Maki Rolls', 'Rollos tradicionales japoneses', 2),
(9, 'Special Rolls', 'Creaciones exclusivas del chef', 2),
(10, 'Postres Japoneses', 'Dulces tradicionales orientales', 2),
(11, 'Entradas Mexicanas', 'Guacamole, quesadillas y más', 3),
(12, 'Platos Fuertes', 'Tacos, enchiladas y chiles rellenos', 3),
(13, 'Acompañamientos', 'Arroz, frijoles y salsas', 3),
(14, 'Bebidas Típicas', 'Aguas frescas y margaritas', 3),
(15, 'Postres Mexicanos', 'Flan, churros y más', 3),
(16, 'Entradas Chinas', 'Sopas y rollitos primavera', 4),
(17, 'Platos Principales', 'Arroces y salteados', 4),
(18, 'Especialidades', 'Platos signature del chef', 4),
(19, 'Acompañamientos', 'Vegetales y fideos', 4),
(20, 'Postres Orientales', 'Frutas y dulces chinos', 4),
(21, 'Tapas', 'Selección de entremeses españoles', 5),
(22, 'Paellas', 'Diferentes variedades de paella', 5),
(23, 'Mariscos', 'Platos adicionales de mariscos', 5),
(24, 'Acompañamientos', 'Pan con tomate y aliños', 5),
(25, 'Postres Españoles', 'Crema catalana y churros', 5),
(26, 'Entradas Indias', 'Samosas y pakoras', 6),
(27, 'Curries', 'Variedad de curries picantes', 6),
(28, 'Arroces', 'Basmati y especialidades', 6),
(29, 'Panes Indios', 'Naan, roti y paratha', 6),
(30, 'Postres Indios', 'Gulab jamun y kheer', 6),
(31, 'Ceviches', 'Diferentes estilos de ceviche', 7),
(32, 'Causas', 'Variedades de causa limeña', 7),
(33, 'Platos Principales', 'Lomo saltado y otros', 7),
(34, 'Acompañamientos', 'Arroz, camote y choclo', 7),
(35, 'Postres Peruanos', 'Suspiro limeño y más', 7),
(36, 'Mezze', 'Selección de entradas árabes', 8),
(37, 'Kebabs', 'Carnes a la parrilla', 8),
(38, 'Especialidades', 'Platos tradicionales libaneses', 8),
(39, 'Acompañamientos', 'Arroz y ensaladas', 8),
(40, 'Postres Árabes', 'Baklava y kunafeh', 8),
(41, 'Entradas', 'Empanadas y provoletas', 9),
(42, 'Cortes Premium', 'Variedad de carnes argentinas', 9),
(43, 'Guarniciones', 'Papas, ensaladas y chimichurri', 9),
(44, 'Especialidades', 'Morcilla y chorizos', 9),
(45, 'Postres Argentinos', 'Flan con dulce de leche', 9),
(46, 'Entradas Japonesas', 'Gyozas y edamame', 10),
(47, 'Ramen', 'Diferentes tipos de ramen', 10),
(48, 'Donburi', 'Tazones de arroz con toppings', 10),
(49, 'Acompañamientos', 'Arroz extra y vegetales', 10),
(50, 'Postres Japoneses', 'Mochi y dorayaki', 10),
(51, 'Arepas', 'Diferentes tipos de arepas', 11),
(52, 'Pabellones', 'Pabellón tradicional y variantes', 11),
(53, 'Asados', 'Carnes a la parrilla criollas', 11),
(54, 'Acompañamientos', 'Tajadas, queso y más', 11),
(55, 'Postres Venezolanos', 'Golfeados y quesillo', 11),
(56, 'Platos Navideños', 'Hallacas y pan de jamón', 12),
(57, 'Ensaladas', 'Ensalada de gallina y otras', 12),
(58, 'Sopas', 'Sopas tradicionales venezolanas', 12),
(59, 'Acompañamientos', 'Pan, arepas y más', 12),
(60, 'Postres Típicos', 'Dulce de lechosa y otros', 12),
(61, 'Hallaquitas Clásicas', 'Tradicionales de maíz', 13),
(62, 'Hallaquitas Gourmet', 'Con rellenos especiales', 13),
(63, 'Acompañamientos', 'Salsas y guarniciones', 13),
(64, 'Proteínas', 'Carnes para acompañar', 13),
(65, 'Postres', 'Dulces para finalizar', 13),
(66, 'Entradas de Mar', 'Ceviches y cocteles', 14),
(67, 'Platos Principales', 'Pescados fritos y asados', 14),
(68, 'Mariscos', 'Camarones y pulpo', 14),
(69, 'Acompañamientos', 'Tostones y ensaladas', 14),
(70, 'Postres Marinos', 'Dulces con coco', 14),
(71, 'Empanadas Clásicas', 'Carne mechada, pollo, queso', 15),
(72, 'Empanadas Especiales', 'Rellenos gourmet', 15),
(73, 'Acompañamientos', 'Salsas picantes y guasacaca', 15),
(74, 'Ensaladas', 'Para balancear la comida', 15),
(75, 'Postres', 'Dulces tradicionales', 15),
(76, 'Tequeños', 'Diferentes tamaños y rellenos', 16),
(77, 'Pastelitos', 'Variedad de pastelitos', 16),
(78, 'Bebidas', 'Jugos y refrescos', 16),
(79, 'Combos', 'Combinaciones especiales', 16),
(80, 'Postres', 'Opciones dulces', 16),
(81, 'Cachapas', 'Clásicas y especiales', 17),
(82, 'Rellenos', 'Quesos y carnes', 17),
(83, 'Acompañamientos', 'Guasacaca y otros', 17),
(84, 'Bebidas', 'Jugos naturales', 17),
(85, 'Postres', 'Dulces con maíz', 17),
(86, 'Sopas', 'Mondongo, sancocho, sopa de res', 18),
(87, 'Acompañamientos', 'Arepas, pan, aguacate', 18),
(88, 'Proteínas', 'Carnes adicionales', 18),
(89, 'Ensaladas', 'Para acompañar', 18),
(90, 'Postres', 'Dulces ligeros', 18),
(91, 'Asados', 'Carne, pollo y cerdo', 19),
(92, 'Guisos', 'Mechada, asado negro', 19),
(93, 'Acompañamientos', 'Arroz, plátano, vegetales', 19),
(94, 'Arepas', 'Diferentes tipos', 19),
(95, 'Postres', 'Dulces tradicionales', 19),
(96, 'Sancochos', 'Diferentes tipos', 20),
(97, 'Tamaños', 'Porciones individuales y familiares', 20),
(98, 'Acompañamientos', 'Arroz, aguacate, arepas', 20),
(99, 'Proteínas Extra', 'Carnes adicionales', 20),
(100, 'Postres Familiares', 'Para compartir', 20),
(101, 'Bebidas Calientes', 'Café, chocolate, té', 21),
(102, 'Jugos Naturales', 'Variedad de frutas', 21),
(103, 'Panadería', 'Arepas, pan, pasteles', 21),
(104, 'Proteínas', 'Huevos, jamón, queso', 21),
(105, 'Fruta Fresca', 'Porción de fruta de temporada', 21),
(106, 'Panes Franceses', 'Baguettes y croissants', 22),
(107, 'Pastelería', 'Tartas y pasteles', 22),
(108, 'Sandwiches', 'Clásicos franceses', 22),
(109, 'Bebidas', 'Café, té, chocolate', 22),
(110, 'Postres', 'Macarons y más', 22),
(111, 'Chocolates', 'Diferentes porcentajes y sabores', 23),
(112, 'Acompañamientos', 'Pan, galletas, fruta', 23),
(113, 'Toppings', 'Crema, marshmallows, especias', 23),
(114, 'Bebidas Complementarias', 'Té, café', 23),
(115, 'Postres de Chocolate', 'Brownies, tortas', 23),
(116, 'Tartas', 'Variedad de tartas finas', 24),
(117, 'Mousses', 'Diferentes sabores', 24),
(118, 'Helados', 'Postres congelados', 24),
(119, 'Mini Postres', 'Porciones pequeñas variadas', 24),
(120, 'Bebidas de Acompañamiento', 'Café, té, licores', 24),
(121, 'Tés', 'Variedad de tés del mundo', 25),
(122, 'Sandwiches', 'Mini sandwiches variados', 25),
(123, 'Scones', 'Clásicos ingleses', 25),
(124, 'Pastelitos', 'Variedad dulce', 25),
(125, 'Mermeladas', 'Acompañamientos para scones', 25),
(126, 'Hamburguesas', 'Diferentes tipos y tamaños', 26),
(127, 'Acompañamientos', 'Papas, aros de cebolla', 26),
(128, 'Bebidas', 'Refrescos y cervezas', 26),
(129, 'Combos', 'Ofertas especiales', 26),
(130, 'Postres', 'Helados y batidos', 26),
(131, 'Pizzas', 'Variedad de sabores', 27),
(132, 'Acompañamientos', 'Palitos de ajo, ensaladas', 27),
(133, 'Bebidas', 'Refrescos y vinos', 27),
(134, 'Combos Familiares', 'Para 4-6 personas', 27),
(135, 'Postres', 'Cannoli y otros', 27),
(136, 'Hot Dogs', 'Diferentes estilos y tamaños', 28),
(137, 'Acompañamientos', 'Papas, nuggets', 28),
(138, 'Bebidas', 'Refrescos y cervezas', 28),
(139, 'Combos', 'Ofertas especiales', 28),
(140, 'Postres', 'Donuts y otros', 28),
(141, 'Pollo', 'Diferentes porciones', 29),
(142, 'Acompañamientos', 'Ensaladas, papas, arepas', 29),
(143, 'Salsas', 'Variedad de salsas', 29),
(144, 'Combos', 'Ofertas familiares', 29),
(145, 'Postres', 'Dulces ligeros', 29),
(146, 'Tacos', 'Diferentes proteínas y estilos', 30),
(147, 'Acompañamientos', 'Arroz, frijoles', 30),
(148, 'Salsas', 'Variedad de salsas mexicanas', 30),
(149, 'Bebidas', 'Margaritas y refrescos', 30),
(150, 'Postres', 'Churros y flan', 30),
(151, 'Entradas Veganas', 'Ensaladas y dips', 31),
(152, 'Platos Principales', 'Hamburguesas, pastas veganas', 31),
(153, 'Bowl Veganos', 'Combinaciones saludables', 31),
(154, 'Acompañamientos', 'Vegetales y granos', 31),
(155, 'Postres Veganos', 'Sin ingredientes animales', 31),
(156, 'Entradas Orgánicas', 'Ensaladas y sopas', 32),
(157, 'Platos Principales', 'Certificados orgánicos', 32),
(158, 'Bebidas', 'Jugos y tés orgánicos', 32),
(159, 'Acompañamientos', 'Vegetales orgánicos', 32),
(160, 'Postres Orgánicos', 'Dulces saludables', 32),
(161, 'Entradas Sin Gluten', 'Opciones seguras', 33),
(162, 'Platos Principales', 'Elaborados sin gluten', 33),
(163, 'Panadería', 'Panes y galletas sin gluten', 33),
(164, 'Acompañamientos', 'Seguros para celíacos', 33),
(165, 'Postres Sin Gluten', 'Dulces especiales', 33),
(166, 'Rolls Saludables', 'Con arroz integral y vegetales', 34),
(167, 'Poke Bowls', 'Tazones saludables', 34),
(168, 'Ensaladas', 'Con ingredientes frescos', 34),
(169, 'Sopas', 'Ligeras y nutritivas', 34),
(170, 'Postres Saludables', 'Bajas calorías', 34),
(171, 'Jugos Detox', 'Combinaciones depurativas', 35),
(172, 'Ensaladas', 'Superfoods y vegetales', 35),
(173, 'Sopas', 'Desintoxicantes', 35),
(174, 'Bowl Nutritivos', 'Comidas balanceadas', 35),
(175, 'Snacks Saludables', 'Barras y frutos secos', 35);

INSERT INTO Plato(id,nombre,orden,cantidadDisponible,precio,descripcion,idSeccion)
VALUES
(1, 'Bruschetta Clásica', 1, 25, 8.50, 'Pan tostado con tomate, ajo y albahaca fresca', 1),
(2, 'Antipasto Misto', 2, 20, 12.00, 'Selección de embutidos y quesos italianos con pan rústico', 1),
(3, 'Spaghetti Carbonara', 1, 30, 15.50, 'Pasta con salsa cremosa de huevo, panceta y pimienta negra', 2),
(4, 'Risotto ai Funghi', 2, 18, 16.00, 'Arroz arbóreo cremoso con hongos porcini y parmesano', 2),
(5, 'Saltimbocca alla Romana', 1, 15, 22.00, 'Ternera con prosciutto, salvia y vino blanco', 3),
(6, 'Tiramisú Clásico', 1, 20, 9.00, 'Postre de café, mascarpone y cacao en polvo', 5),
(7, 'Sashimi de Salmón', 1, 15, 18.00, 'Frescos cortes de salmón premium', 6),
(8, 'Nigiri de Atún', 2, 12, 16.00, 'Arroz con lomo de atún rojo', 7),
(9, 'Maki California', 1, 25, 14.00, 'Roll con cangrejo, aguacate y pepino', 8),
(10, 'Tempura de Verduras', 3, 20, 10.50, 'Variedad de vegetales rebozados ligeramente', 9),
(11, 'Mochi de Té Verde', 1, 30, 7.50, 'Postre japonés de arroz con helado de matcha', 10),
(12, 'Guacamole Tradicional', 1, 35, 8.00, 'Molido en molcajete con aguacate, tomate y cilantro', 11),
(13, 'Tacos al Pastor', 1, 40, 12.50, 'Tortillas de maíz con carne adobada y piña', 12),
(14, 'Chiles Rellenos', 2, 15, 14.00, 'Pimientos poblanos rellenos de carne y queso fundido', 12),
(15, 'Horchata', 1, 50, 5.00, 'Bebida refrescante de arroz y canela', 14),
(16, 'Flan Napolitano', 1, 20, 6.50, 'Postre cremoso de vainilla con caramelo', 15),
(17, 'Sopa Wantán', 1, 30, 7.50, 'Caldo con wontons de cerdo y vegetales', 16),
(18, 'Cerdo Agridulce', 1, 25, 13.50, 'Carne con salsa característica y piña', 17),
(19, 'Pato a la Naranja', 2, 10, 24.00, 'Clásico de la cocina china con piel crujiente', 18),
(20, 'Rollitos Primavera', 2, 35, 9.00, 'Crujientes con vegetales y salsa dulce', 16),
(21, 'Gelatina de Coco', 1, 20, 5.50, 'Postre refrescante con leche de coco', 20),
(22, 'Paella Valenciana', 1, 12, 28.00, 'Arroz con conejo, pollo, garrofón y romero', 22),
(23, 'Tortilla Española', 1, 25, 10.00, 'Tortilla de patatas tradicional con cebolla', 21),
(24, 'Gambas al Ajillo', 2, 30, 16.00, 'Camarones en aceite de oliva con ajo y guindilla', 23),
(25, 'Crema Catalana', 1, 20, 7.00, 'Postre similar a la crema brûlée con canela', 25),
(26, 'Samosas Vegetarianas', 1, 30, 8.50, 'Empanadillas de vegetales con especias', 26),
(27, 'Butter Chicken', 1, 20, 17.00, 'Pollo en salsa de mantequilla y tomate', 27),
(28, 'Naan Tradicional', 1, 40, 4.50, 'Pan indio cocido en tandoor', 29),
(29, 'Gulab Jamun', 1, 25, 6.00, 'Bolitas de leche en almíbar de rosas', 30),
(30, 'Ceviche Clásico', 1, 15, 18.00, 'Pescado marinado en leche de tigre', 31),
(31, 'Causa Limeña', 2, 20, 12.00, 'Pastel de papa amarilla con pollo o atún', 32),
(32, 'Lomo Saltado', 1, 25, 16.50, 'Salteado de carne con tomate y papas fritas', 33),
(33, 'Suspiro Limeño', 1, 20, 7.00, 'Postre de manjarblanco y merengue', 35),
(34, 'Hummus Tradicional', 1, 30, 8.00, 'Puré de garbanzos con tahini', 36),
(35, 'Kebab Mixto', 1, 20, 19.00, 'Selección de carnes a la parrilla', 37),
(36, 'Falafel', 2, 35, 9.50, 'Croquetas de garbanzos con especias', 36),
(37, 'Baklava', 1, 25, 6.50, 'Postre de hojaldre con nueces y miel', 40),
(38, 'Empanadas de Carne', 1, 40, 10.00, 'Rellenas con carne cortada a cuchillo', 41),
(39, 'Bife de Chorizo', 1, 15, 25.00, 'Corte premium de 300g con chimichurri', 42),
(40, 'Provoleta', 2, 20, 12.00, 'Queso provolone a la parrilla', 41),
(41, 'Flan con Dulce de Leche', 1, 20, 7.50, 'Postre tradicional argentino', 45),
(42, 'Arepa Reina Pepiada', 1, 35, 9.00, 'Rellena con pollo y aguacate', 51),
(43, 'Pabellón Criollo', 1, 25, 14.00, 'Carne mechada, caraotas, arroz y plátano', 52),
(44, 'Asado Negro', 2, 15, 16.50, 'Carne en salsa oscura con vino', 53),
(45, 'Quesillo', 1, 30, 6.00, 'Flan venezolano tradicional', 55),
(46, 'Hamburguesa Clásica', 1, 50, 10.00, 'Carne, queso, lechuga y tomate', 126),
(47, 'Pizza Margherita', 1, 15, 18.00, 'Salsa de tomate, mozzarella y albahaca', 131),
(48, 'Hot Dog Especial', 1, 40, 8.50, 'Con repollo, salsas y tocineta', 136),
(49, 'Pollo a la Brasa', 1, 20, 14.00, '1/4 de pollo con especias', 141),
(50, 'Tacos de Carnitas', 1, 35, 12.00, 'Tortillas con cerdo desmenuzado', 146),
(51, 'Buddha Bowl Vegano', 1, 20, 13.50, 'Arroz integral, vegetales y tofu', 153),
(52, 'Ensalada César Orgánica', 1, 25, 11.00, 'Con pollo orgánico y aderezo casero', 156),
(53, 'Pasta Sin Gluten', 1, 15, 14.50, 'Con salsa de tomate natural', 162),
(54, 'Poke Bowl de Salmón', 1, 18, 16.00, 'Arroz, salmón fresco y vegetales', 167),
(55, 'Jugo Verde Detox', 1, 30, 6.50, 'Espinaca, manzana, apio y limón', 171),
(56, 'Lasagna Tradicional', 3, 18, 17.50, 'Capas de pasta, carne y bechamel', 2),
(57, 'Ravioli de Ricotta', 4, 15, 16.00, 'Rellenos de queso con salsa de tomate', 2),
(58, 'Tarta de Manzana', 2, 12, 8.50, 'Con canela y helado de vainilla', 5),
(59, 'Uramaki Philadelphia', 2, 20, 15.00, 'Roll con salmón, queso crema y pepino', 8),
(60, 'Sopa Miso', 4, 25, 6.50, 'Caldo tradicional japonés con tofu', 9),
(61, 'Enchiladas Verdes', 3, 18, 13.50, 'Tortillas rellenas con salsa verde', 12),
(62, 'Churros con Chocolate', 2, 30, 7.00, 'Crujientes con salsa espesa de chocolate', 15),
(63, 'Pato Laqueado', 3, 10, 26.00, 'Con piel crujiente y salsa hoisin', 18),
(64, 'Patatas Bravas', 3, 25, 9.00, 'Papas con salsa picante y alioli', 21),
(65, 'Tarta de Santiago', 2, 15, 8.00, 'Postre de almendra tradicional', 25),
(66, 'Tikka Masala', 2, 20, 16.50, 'Pollo en salsa cremosa de especias', 27),
(67, 'Arroz Basmati', 2, 40, 5.00, 'Acompañamiento tradicional', 28),
(68, 'Causa de Pollo', 3, 18, 11.50, 'Variante con pollo desmenuzado', 32),
(69, 'Tabule Libanés', 3, 20, 10.00, 'Ensalada de trigo bulgur y perejil', 36),
(70, 'Costillas de Cordero', 3, 12, 22.00, 'Marinadas con hierbas mediterráneas', 37),
(71, 'Alfajores', 2, 30, 5.50, 'Galletas rellenas de dulce de leche', 45),
(72, 'Cachapa con Queso', 2, 25, 9.50, 'Tortilla dulce de maíz con queso', 81),
(73, 'Sancocho de Gallina', 1, 15, 14.00, 'Sopa tradicional con verduras', 86),
(74, 'Cheeseburger', 2, 40, 11.50, 'Con queso cheddar y panceta', 126),
(75, 'Pizza Pepperoni', 2, 15, 19.50, 'Con pepperoni y extra queso', 131),
(76, 'Nachos Supreme', 1, 25, 10.50, 'Totopos con carne, queso y guacamole', 11),
(77, 'Ensalada Caprese', 4, 20, 12.00, 'Tomate, mozzarella y albahaca', 1),
(78, 'Salmón Teriyaki', 4, 15, 20.00, 'Con salsa teriyaki y vegetales', 47),
(79, 'Arroz Chaufa', 3, 25, 13.00, 'Arroz frito estilo peruano-chino', 33),
(80, 'Chocolate Fondant', 3, 15, 9.00, 'Con corazón líquido y helado', 5),
(81, 'Pasta Puttanesca', 5, 20, 14.50, 'Con anchoas, aceitunas y alcaparras', 2),
(82, 'Gyudon', 3, 18, 15.00, 'Bowl de arroz con carne y cebolla', 48),
(83, 'Mole Poblano', 4, 12, 16.00, 'Pollo con salsa de chocolate y chiles', 12),
(84, 'Dim Sum Mixto', 5, 20, 14.00, 'Selección de bocados al vapor', 16),
(85, 'Torrijas', 3, 15, 7.50, 'Postre de pan empapado en leche', 25),
(86, 'Vindaloo de Cordero', 3, 12, 18.50, 'Curry picante de Goa', 27),
(87, 'Chicha Morada', 2, 30, 5.00, 'Bebida peruana de maíz morado', 34),
(88, 'Shawarma de Pollo', 4, 25, 13.50, 'En pan pita con ajo y vegetales', 38),
(89, 'Provoleta con Oregano', 3, 20, 11.50, 'Queso fundido con hierbas', 41),
(90, 'Tres Leches', 2, 15, 8.00, 'Pastel húmedo con leches', 55),
(91, 'Tequeños Tradicionales', 3, 40, 9.00, 'Palitos de queso envueltos en masa', 76),
(92, 'Pabellón Vegetariano', 3, 15, 13.00, 'Versión con carne de soja', 52),
(93, 'Milanesa Napolitana', 4, 18, 16.00, 'Carne empanizada con jamón y queso', 3),
(94, 'Ramen Tonkotsu', 2, 15, 17.00, 'Caldo de cerdo con fideos', 47),
(95, 'Burrito Supreme', 3, 20, 14.50, 'Tortilla grande rellena de carne', 12),
(96, 'Pulpo a la Gallega', 5, 10, 22.00, 'Con papas y pimentón', 23),
(97, 'Kulfi de Pistacho', 2, 20, 6.50, 'Helado tradicional indio', 30),
(98, 'Causa de Mariscos', 4, 15, 17.00, 'Con mezcla de mariscos frescos', 32),
(99, 'Kibbeh Crujiente', 5, 25, 11.00, 'Croquetas de trigo y carne picada', 36),
(100, 'Matambre Arrollado', 4, 12, 19.00, 'Carne rellena y asada', 42),
(101, 'Majarete', 3, 20, 6.00, 'Postre de maíz y coco', 55),
(102, 'Hamburguesa Vegana', 3, 20, 13.00, 'Con quinoa y vegetales', 126),
(103, 'Pizza Vegetariana', 3, 15, 18.50, 'Con variedad de vegetales asados', 131),
(104, 'Tacos de Pescado', 2, 20, 15.00, 'Con filete de pargo y repollo', 146),
(105, 'Quinoa Bowl', 2, 18, 14.00, 'Con vegetales asados y aderezo', 153),
(106, 'Ensalada de Lentejas', 3, 20, 11.50, 'Con vegetales frescos y vinagreta', 156),
(107, 'Pasta Primavera', 4, 15, 15.00, 'Con vegetales de temporada', 162),
(108, 'Poke de Atún', 2, 12, 18.00, 'Con aguacate y semillas', 167),
(109, 'Jugo de Remolacha', 2, 25, 6.00, 'Con zanahoria y jengibre', 171),
(110, 'Cannoli Siciliano', 4, 15, 8.50, 'Tubos crujientes rellenos de ricotta', 5),
(111, 'Tempura de Camarón', 5, 18, 17.50, 'Camarones rebozados ligeramente', 9),
(112, 'Chiles en Nogada', 5, 10, 19.00, 'Rellenos de picadillo con salsa de nuez', 12),
(113, 'Pato Pekín', 4, 8, 28.00, 'Con piel crujiente y panqueques', 18),
(114, 'Gazpacho Andaluz', 5, 20, 8.50, 'Sopa fría de tomate y pepino', 21),
(115, 'Korma Vegetariano', 4, 15, 14.50, 'Curry suave con vegetales', 27),
(116, 'Lentejas al Curry', 5, 20, 12.00, 'Con arroz basmati', 27),
(117, 'Ceviche Mixto', 5, 15, 20.00, 'Con pescado, pulpo y camarones', 31),
(118, 'Fattoush', 5, 20, 10.50, 'Ensalada libanesa con pan tostado', 36),
(119, 'Empanadas Arabes', 5, 30, 9.50, 'Rellenas de carne y piñones', 36),
(120, 'Dulce de Leche Pancakes', 5, 15, 9.00, 'Con frutas frescas', 45);

INSERT INTO Opcion(id,nombre,descripcion)
VALUES
-- Toppings y aderezos (1-10)
(0, 'Sin Opcion', ''),
(1, 'Extra queso', 'Añadir queso adicional al plato'),
(2, 'Tocineta crujiente', 'Tiras de tocineta crocante como topping'),
(3, 'Aguacate extra', 'Porción adicional de aguacate fresco'),
(4, 'Salsa picante', 'Añadir salsa picante al gusto'),
(5, 'Cebolla caramelizada', 'Topping de cebolla cocida lentamente'),
(6, 'Champiñones salteados', 'Hongos cocidos con ajo y perejil'),
(7, 'Pepinillos encurtidos', 'Rodajas de pepinillo agridulce'),
(8, 'Sour cream', 'Crema agria para acompañar'),
(9, 'Guacamole extra', 'Porción adicional de guacamole casero'),
(10, 'Queso rallado', 'Espolvoreado de queso parmesano o similar'),
-- Acompañamientos (11-20)
(11, 'Papas fritas', 'Porción de papas fritas tradicionales'),
(12, 'Ensalada verde', 'Mezcla de lechugas frescas'),
(13, 'Arroz blanco', 'Acompañamiento de arroz vaporizado'),
(14, 'Vegetales al vapor', 'Mezcla de vegetales frescos cocidos al vapor'),
(15, 'Puré de papas', 'Crema suave de papas con mantequilla'),
(16, 'Tostones', 'Plátanos verdes fritos dos veces'),
(17, 'Frijoles refritos', 'Frijoles cocidos y machacados'),
(18, 'Pan de ajo', 'Rebanadas de pan con ajo y perejil'),
(19, 'Sopa del día', 'Sopa casera según disponibilidad'),
(20, 'Arepa pequeña', 'Arepa de maíz blanco como acompañante'),
-- Tamaños y porciones (21-25)
(21, 'Porción individual', 'Tamaño estándar para una persona'),
(22, 'Porción familiar', 'Tamaño grande para compartir'),
(23, 'Media porción', 'Mitad del tamaño estándar'),
(24, 'Porción del chef', 'Tamaño generoso recomendado por el chef'),
(25, 'Porción infantil', 'Tamaño reducido para niños'),
-- Modificaciones de preparación (26-35)
(26, 'Sin cebolla', 'Excluir cebolla de la preparación'),
(27, 'Sin ajo', 'Preparación sin ajo'),
(28, 'Poco picante', 'Reducir cantidad de picante'),
(29, 'Bien cocido', 'Cocción completa de las carnes'),
(30, 'Al punto', 'Cocción media de las carnes'),
(31, 'Poco hecho', 'Cocción ligera de las carnes'),
(32, 'Sin sal añadida', 'Preparación con mínima sal'),
(33, 'Vegetariana', 'Versión sin ingredientes cárnicos'),
(34, 'Vegana', 'Versión sin ningún producto animal'),
(35, 'Sin gluten', 'Preparación apta para celíacos'),
-- Ingredientes premium (36-40)
(36, 'Trufa rallada', 'Topping de trufa negra fresca'),
(37, 'Caviar', 'Pequeña porción de caviar premium'),
(38, 'Foie gras', 'Porción de paté de foie gras'),
(39, 'Langosta', 'Añadir langosta como ingrediente extra'),
(40, 'Jamón ibérico', 'Finas láminas de jamón ibérico de bellota');

INSERT INTO PlatoOpcion(idPlato,idOpcion)
VALUES
(1, 0),
(2, 0),
(3, 0),
(4, 0),
(5, 0),
(6, 0),
(7, 0),
(8, 0),
(9, 0),
(10, 0),
(11, 0),
(12, 0),
(13, 0),
(14, 0),
(15, 0),
(16, 0),
(17, 0),
(18, 0),
(19, 0),
(20, 0),
(21, 0),
(22, 0),
(23, 0),
(24, 0),
(25, 0),
(26, 0),
(27, 0),
(28, 0),
(29, 0),
(30, 0),
(31, 0),
(32, 0),
(33, 0),
(34, 0),
(35, 0),
(36, 0),
(37, 0),
(38, 0),
(39, 0),
(40, 0),
(41, 0),
(42, 0),
(43, 0),
(44, 0),
(45, 0),
(46, 0),
(47, 0),
(48, 0),
(49, 0),
(50, 0),
(51, 0),
(52, 0),
(53, 0),
(54, 0),
(55, 0),
(56, 0),
(57, 0),
(58, 0),
(59, 0),
(60, 0),
(61, 0),
(62, 0),
(63, 0),
(64, 0),
(65, 0),
(66, 0),
(67, 0),
(68, 0),
(69, 0),
(70, 0),
(71, 0),
(72, 0),
(73, 0),
(74, 0),
(75, 0),
(76, 0),
(77, 0),
(78, 0),
(79, 0),
(80, 0),
(81, 0),
(82, 0),
(83, 0),
(84, 0),
(85, 0),
(86, 0),
(87, 0),
(88, 0),
(89, 0),
(90, 0),
(91, 0),
(92, 0),
(93, 0),
(94, 0),
(95, 0),
(96, 0),
(97, 0),
(98, 0),
(99, 0),
(100, 0),
(101, 0),
(102, 0),
(103, 0),
(104, 0),
(105, 0),
(106, 0),
(107, 0),
(108, 0),
(109, 0),
(110, 0),
(111, 0),
(112, 0),
(113, 0),
(114, 0),
(115, 0),
(116, 0),
(117, 0),
(118, 0),
(119, 0),
(120, 0),
(1, 1),   -- Bruschetta con extra queso
(1, 10),  -- Bruschetta con queso rallado
(3, 1),   -- Spaghetti Carbonara con extra queso
(3, 30),  -- Spaghetti Carbonara al punto
(4, 6),   -- Risotto con champiñones extra
(4, 36),  -- Risotto con trufa rallada
(7, 4),   -- Sashimi con salsa picante
(9, 3),   -- Maki California con aguacate extra
(9, 9),   -- Maki California con guacamole extra
(10, 28), -- Tempura poco picante
(11, 25), -- Mochi en porción infantil
(12, 2),  -- Guacamole con tocineta
(13, 4),  -- Tacos al Pastor con salsa picante
(13, 7),  -- Tacos al Pastor con pepinillos
(14, 1),  -- Chiles Rellenos con extra queso
(15, 17), -- Horchata con frijoles refritos
(16, 25), -- Flan en porción infantil
(17, 12), -- Sopa Wantán con ensalada
(18, 4),  -- Cerdo Agridulce con salsa picante
(19, 24), -- Pato Pekín en porción del chef
(20, 13), -- Rollitos Primavera con arroz
(21, 23), -- Gelatina de Coco en media porción
(22, 22), -- Paella en porción familiar
(23, 18), -- Tortilla con pan de ajo
(24, 5),  -- Gambas al Ajillo con cebolla caramelizada
(25, 25), -- Crema Catalana en porción infantil
(26, 4),  -- Samosas con salsa picante
(27, 28), -- Butter Chicken poco picante
(28, 13), -- Naan con arroz blanco
(29, 25), -- Gulab Jamun en porción infantil
(30, 14), -- Ceviche con vegetales al vapor
(31, 3),  -- Causa Limeña con aguacate extra
(32, 29), -- Lomo Saltado bien cocido
(33, 25), -- Suspiro Limeño en porción infantil
(34, 8),  -- Hummus con sour cream
(35, 7),  -- Kebab con pepinillos
(36, 4),  -- Falafel con salsa picante
(37, 25), -- Baklava en porción infantil
(38, 11), -- Empanadas con papas fritas
(39, 31), -- Bife de Chorizo poco hecho
(40, 18), -- Provoleta con pan de ajo
(41, 25), -- Flan en porción infantil
(42, 3),  -- Arepa Reina Pepiada con aguacate extra
(43, 20), -- Pabellón con arepa pequeña
(44, 29), -- Asado Negro bien cocido
(45, 25), -- Quesillo en porción infantil
(46, 1),  -- Hamburguesa con extra queso
(46, 2),  -- Hamburguesa con tocineta
(47, 1),  -- Pizza con extra queso
(48, 4),  -- Hot Dog con salsa picante
(49, 15), -- Pollo a la Brasa con puré
(50, 4),  -- Tacos con salsa picante
(51, 14), -- Buddha Bowl con vegetales al vapor
(52, 35), -- Ensalada César sin gluten
(53, 34), -- Pasta en versión vegana
(54, 32), -- Poke Bowl sin sal añadida
(55, 33), -- Jugo Detox en versión vegetariana
(5, 36),  -- Saltimbocca con trufa
(19, 37), -- Pato Pekín con caviar
(24, 40), -- Gambas al Ajillo con jamón ibérico
(39, 38), -- Bife de Chorizo con foie gras
(22, 39);  -- Paella con langosta

INSERT INTO OpcionValor(id,idOpcion,nombre,precio_extra)
VALUES
(0, 0, 'Nada',0),
(1, 1, 'Queso mozzarella', 1.50),
(2, 1, 'Queso cheddar', 1.75),
(3, 1, 'Queso parmesano', 2.00),
(1, 2, 'Porción estándar', 2.00),
(2, 2, 'Porción grande', 3.50),
(1, 3, '1/2 aguacate', 1.50),
(2, 3, 'Aguacate completo', 2.75),
(1, 4, 'Suave', 0.50),
(2, 4, 'Medio', 0.50),
(3, 4, 'Picante', 0.50),
(4, 4, 'Extra picante', 0.50),
(1, 5, 'Porción pequeña', 1.25),
(2, 5, 'Porción grande', 2.00),
(1, 6, 'Porción estándar', 1.75),
(2, 6, 'Porción extra', 2.50),
(1, 7, 'Porción normal', 0.75),
(1, 8, 'Porción individual', 0.75),
(2, 8, 'Porción extra', 1.25),
(1, 9, 'Porción pequeña', 2.00),
(2, 9, 'Porción grande', 3.50),
(1, 10, 'Parmesano', 1.00),
(2, 10, 'Manchego', 1.25),
(3, 10, 'Mezcla de quesos', 1.50),
(1, 11, 'Pequeñas', 2.50),
(2, 11, 'Medianas', 3.50),
(3, 11, 'Grandes', 4.50),
(1, 12, 'Individual', 3.00),
(2, 12, 'Para compartir', 5.00),
(1, 13, 'Porción pequeña', 1.50),
(2, 13, 'Porción grande', 2.50),
(1, 14, 'Mezcla estándar', 2.75),
(2, 14, 'Selección premium', 3.50),
(1, 15, 'Porción individual', 2.25),
(2, 15, 'Porción familiar', 4.00),
(1, 16, '6 unidades', 3.00),
(2, 16, '12 unidades', 5.00),
(1, 17, 'Porción estándar', 1.75),
(1, 18, '4 rebanadas', 2.50),
(2, 18, '8 rebanadas', 4.00),
(1, 19, 'Bowl individual', 3.50),
(2, 19, 'Taza', 2.50),
(1, 20, 'Blanca', 1.50),
(2, 20, 'Amarilla', 1.75),
(1, 21, 'Estándar', 0.00),
(1, 22, 'Para 4 personas', 8.00),
(2, 22, 'Para 6 personas', 12.00),
(1, 23, 'Mitad de porción', 0),
(1, 24, 'Recomendación del chef', 5.00),
(1, 25, 'Menú niños', 0),
(1, 36, '2 gramos', 12.00),
(2, 36, '5 gramos', 25.00),
(1, 37, '10 gramos', 35.00),
(2, 37, '20 gramos', 65.00),
(1, 38, '50 gramos', 18.00),
(2, 38, '100 gramos', 32.00),
(1, 39, '1/2 langosta', 25.00),
(2, 39, 'Langosta entera', 45.00),
(1, 40, '5 láminas', 15.00),
(2, 40, '10 láminas', 28.00);

INSERT INTO PlatoOpcionValor(idPlato,idOpcionValor,idOpcion)
VALUES
(1, 0, 0),
(2, 0, 0),
(3, 0, 0),
(4, 0, 0),
(5, 0, 0),
(6, 0, 0),
(7, 0, 0),
(8, 0, 0),
(9, 0, 0),
(10, 0, 0),
(11, 0, 0),
(12, 0, 0),
(13, 0, 0),
(14, 0, 0),
(15, 0, 0),
(16, 0, 0),
(17, 0, 0),
(18, 0, 0),
(19, 0, 0),
(20, 0, 0),
(21, 0, 0),
(22, 0, 0),
(23, 0, 0),
(24, 0, 0),
(25, 0, 0),
(26, 0, 0),
(27, 0, 0),
(28, 0, 0),
(29, 0, 0),
(30, 0, 0),
(31, 0, 0),
(32, 0, 0),
(33, 0, 0),
(34, 0, 0),
(35, 0, 0),
(36, 0, 0),
(37, 0, 0),
(38, 0, 0),
(39, 0, 0),
(40, 0, 0),
(41, 0, 0),
(42, 0, 0),
(43, 0, 0),
(44, 0, 0),
(45, 0, 0),
(46, 0, 0),
(47, 0, 0),
(48, 0, 0),
(49, 0, 0),
(50, 0, 0),
(51, 0, 0),
(52, 0, 0),
(53, 0, 0),
(54, 0, 0),
(55, 0, 0),
(56, 0, 0),
(57, 0, 0),
(58, 0, 0),
(59, 0, 0),
(60, 0, 0),
(61, 0, 0),
(62, 0, 0),
(63, 0, 0),
(64, 0, 0),
(65, 0, 0),
(66, 0, 0),
(67, 0, 0),
(68, 0, 0),
(69, 0, 0),
(70, 0, 0),
(71, 0, 0),
(72, 0, 0),
(73, 0, 0),
(74, 0, 0),
(75, 0, 0),
(76, 0, 0),
(77, 0, 0),
(78, 0, 0),
(79, 0, 0),
(80, 0, 0),
(81, 0, 0),
(82, 0, 0),
(83, 0, 0),
(84, 0, 0),
(85, 0, 0),
(86, 0, 0),
(87, 0, 0),
(88, 0, 0),
(89, 0, 0),
(90, 0, 0),
(91, 0, 0),
(92, 0, 0),
(93, 0, 0),
(94, 0, 0),
(95, 0, 0),
(96, 0, 0),
(97, 0, 0),
(98, 0, 0),
(99, 0, 0),
(100, 0, 0),
(101, 0, 0),
(102, 0, 0),
(103, 0, 0),
(104, 0, 0),
(105, 0, 0),
(106, 0, 0),
(107, 0, 0),
(108, 0, 0),
(109, 0, 0),
(110, 0, 0),
(111, 0, 0),
(112, 0, 0),
(113, 0, 0),
(114, 0, 0),
(115, 0, 0),
(116, 0, 0),
(117, 0, 0),
(118, 0, 0),
(119, 0, 0),
(120, 0, 0),
(46, 1, 1),  -- Hamburguesa Clásica con queso mozzarella extra
(46, 2, 1),  -- Hamburguesa Clásica con queso cheddar extra
(46, 1, 2),  -- Hamburguesa Clásica con tocineta estándar
(46, 1, 4),  -- Hamburguesa Clásica con salsa picante suave
(46, 3, 4),  -- Hamburguesa Clásica con salsa picante
(46, 1, 7),  -- Hamburguesa Clásica con pepinillos
(46, 1, 11), -- Hamburguesa Clásica con papas pequeñas
(46, 2, 11), -- Hamburguesa Clásica con papas medianas
(47, 1, 1),  -- Pizza Margherita con queso mozzarella extra
(47, 3, 1),  -- Pizza Margherita con queso parmesano extra
(47, 1, 6),  -- Pizza Margherita con champiñones estándar
(47, 2, 6),  -- Pizza Margherita con champiñones extra
(47, 1, 5),  -- Pizza Margherita con cebolla caramelizada pequeña
(47, 1, 18), -- Pizza Margherita con pan de ajo (4 rebanadas)
(9, 1, 3),   -- Maki California con 1/2 aguacate extra
(9, 2, 3),   -- Maki California con aguacate completo extra
(9, 1, 4),   -- Maki California con salsa picante suave
(9, 1, 8),   -- Maki California con sour cream individual
(9, 1, 13),  -- Maki California con arroz pequeño
(13, 1, 3),  -- Tacos al Pastor con 1/2 aguacate extra
(13, 1, 4),  -- Tacos al Pastor con salsa picante suave
(13, 3, 4),  -- Tacos al Pastor con salsa picante
(13, 1, 9),  -- Tacos al Pastor con guacamole pequeño
(13, 1, 17), -- Tacos al Pastor con frijoles refritos
(5, 1, 36),  -- Saltimbocca con 2g de trufa
(5, 2, 36),  -- Saltimbocca con 5g de trufa
(5, 1, 40),  -- Saltimbocca con 5 láminas de jamón ibérico
(52, 1, 1),  -- Ensalada César con queso mozzarella extra
(52, 1, 3),  -- Ensalada César con 1/2 aguacate extra
(52, 1, 8),  -- Ensalada César con sour cream individual
(52, 1, 12), -- Ensalada César con ensalada verde individual
(3, 1, 1),   -- Spaghetti Carbonara con queso mozzarella extra
(3, 3, 1),   -- Spaghetti Carbonara con queso parmesano extra
(3, 1, 10),  -- Spaghetti Carbonara con queso parmesano rallado
(3, 1, 15),  -- Spaghetti Carbonara con puré individual
(43, 1, 3),  -- Pabellón con 1/2 aguacate extra
(43, 1, 4),  -- Pabellón con salsa picante suave
(43, 1, 20), -- Pabellón con arepa pequeña blanca
(43, 2, 20), -- Pabellón con arepa pequeña amarilla
(6, 1, 10),  -- Tiramisú con queso parmesano rallado
(6, 1, 25),  -- Tiramisú en porción infantil
(51, 1, 14), -- Buddha Bowl con vegetales estándar
(51, 2, 14), -- Buddha Bowl con vegetales premium
(51, 1, 33), -- Buddha Bowl versión vegetariana
(51, 1, 35), -- Buddha Bowl sin gluten
(22, 1, 22), -- Paella en porción familiar para 4
(22, 2, 22), -- Paella en porción familiar para 6
(22, 1, 39), -- Paella con 1/2 langosta
(39, 1, 38), -- Bife de Chorizo con 50g de foie gras
(19, 1, 37), -- Pato Pekín con 10g de caviar
(35, 1, 8),  -- Kebab con sour cream individual
(27, 1, 28), -- Butter Chicken con naan tradicional
(31, 1, 3),  -- Causa Limeña con 1/2 aguacate extra
(16, 1, 25), -- Flan Napolitano en porción infantil
(29, 1, 25), -- Gulab Jamun en porción infantil
(37, 1, 25), -- Baklava en porción infantil
(41, 1, 25), -- Flan en porción infantil
(45, 1, 25);  -- Quesillo en porción infantil

INSERT INTO Cliente(id,[password],telefono,fecha_registro,correo,nombre,apellido,fecha_nac,nro_documento)
VALUES
(1, 'claveSegura1', '555-1001', '2020-01-15', 'cliente1@email.com', 'Juan', 'Chispas', '2005-06-06', 10000001),
(2, 'claveSegura2', '555-1002', '2020-01-16', 'cliente2@email.com', 'María', 'Gómez', '1990-07-22', 10000002),
(3, 'claveSegura3', '555-1003', '2020-01-17', 'cliente3@email.com', 'Carlos', 'Rodríguez', '1982-11-30', 10000003),
(4, 'claveSegura4', '555-1004', '2020-01-18', 'cliente4@email.com', 'Ana', 'López', '1978-03-15', 10000004),
(5, 'claveSegura5', '555-1005', '2020-01-19', 'cliente5@email.com', 'Pedro', 'Martínez', '1995-09-08', 10000005),
(6, 'claveSegura6', '555-1006', '2020-01-20', 'cliente6@email.com', 'Laura', 'Fernández', '1989-12-25', 10000006),
(7, 'claveSegura7', '555-1007', '2020-01-21', 'cliente7@email.com', 'Miguel', 'García', '1975-06-18', 10000007),
(8, 'claveSegura8', '555-1008', '2020-01-22', 'cliente8@email.com', 'Sofía', 'Díaz', '1992-04-05', 10000008),
(9, 'claveSegura9', '555-1009', '2020-01-23', 'cliente9@email.com', 'David', 'Sánchez', '1987-08-12', 10000009),
(10, 'claveSegura10', '555-1010', '2020-01-24', 'cliente10@email.com', 'Elena', 'Romero', '1980-10-30', 10000010),
(11, 'claveSegura11', '555-1011', '2020-02-01', 'cliente11@email.com', 'Javier', 'Álvarez', '1993-01-14', 10000011),
(12, 'claveSegura12', '555-1012', '2020-02-02', 'cliente12@email.com', 'Isabel', 'Morales', '1979-07-19', 10000012),
(13, 'claveSegura13', '555-1013', '2020-02-03', 'cliente13@email.com', 'Francisco', 'Ortiz', '1984-05-22', 10000013),
(14, 'claveSegura14', '555-1014', '2020-02-04', 'cliente14@email.com', 'Carmen', 'Torres', '1991-11-11', 10000014),
(15, 'claveSegura15', '555-1015', '2020-02-05', 'cliente15@email.com', 'Alejandro', 'Ruiz', '1986-02-28', 10000015),
(16, 'claveSegura16', '555-1016', '2020-02-06', 'cliente16@email.com', 'Patricia', 'Jiménez', '1977-09-15', 10000016),
(17, 'claveSegura17', '555-1017', '2020-02-07', 'cliente17@email.com', 'Daniel', 'Navarro', '1994-12-08', 10000017),
(18, 'claveSegura18', '555-1018', '2020-02-08', 'cliente18@email.com', 'Teresa', 'Hernández', '1983-04-17', 10000018),
(19, 'claveSegura19', '555-1019', '2020-02-09', 'cliente19@email.com', 'Raúl', 'Gil', '1988-06-23', 10000019),
(20, 'claveSegura20', '555-1020', '2020-02-10', 'cliente20@email.com', 'Beatriz', 'Serrano', '1976-08-04', 10000020),
(21, 'claveSegura21', '555-1021', '2020-02-11', 'cliente21@email.com', 'Alberto', 'Molina', '1997-03-12', 10000021),
(22, 'claveSegura22', '555-1022', '2020-02-12', 'cliente22@email.com', 'Rosa', 'Castro', '1981-10-21', 10000022),
(23, 'claveSegura23', '555-1023', '2020-02-13', 'cliente23@email.com', 'Fernando', 'Vargas', '1990-01-30', 10000023),
(24, 'claveSegura24', '555-1024', '2020-02-14', 'cliente24@email.com', 'Silvia', 'Reyes', '1978-07-07', 10000024),
(25, 'claveSegura25', '555-1025', '2020-02-15', 'cliente25@email.com', 'Ricardo', 'Campos', '1985-11-19', 10000025),
(26, 'claveSegura26', '555-1026', '2020-02-16', 'cliente26@email.com', 'Nuria', 'Guerrero', '1992-05-28', 10000026),
(27, 'claveSegura27', '555-1027', '2020-02-17', 'cliente27@email.com', 'Óscar', 'Lorenzo', '1987-09-14', 10000027),
(28, 'claveSegura28', '555-1028', '2020-02-18', 'cliente28@email.com', 'Eva', 'Santana', '1979-12-03', 10000028),
(29, 'claveSegura29', '555-1029', '2020-02-19', 'cliente29@email.com', 'Héctor', 'Iglesias', '1995-02-16', 10000029),
(30, 'claveSegura30', '555-1030', '2020-02-20', 'cliente30@email.com', 'Lourdes', 'Delgado', '1984-04-25', 10000030),
(31, 'claveSegura31', '555-1031', '2020-03-01', 'cliente31@email.com', 'Pablo', 'Ramírez', '1989-08-11', 10000031),
(32, 'claveSegura32', '555-1032', '2020-03-02', 'cliente32@email.com', 'Olga', 'Cabrera', '1977-06-29', 10000032),
(33, 'claveSegura33', '555-1033', '2020-03-03', 'cliente33@email.com', 'Gabriel', 'Flores', '1993-10-07', 10000033),
(34, 'claveSegura34', '555-1034', '2020-03-04', 'cliente34@email.com', 'Alicia', 'Márquez', '1982-01-18', 10000034),
(35, 'claveSegura35', '555-1035', '2020-03-05', 'cliente35@email.com', 'Víctor', 'León', '1996-07-22', 10000035),
(36, 'claveSegura36', '555-1036', '2020-03-06', 'cliente36@email.com', 'Marina', 'Peña', '1980-11-15', 10000036),
(37, 'claveSegura37', '555-1037', '2020-03-07', 'cliente37@email.com', 'Rubén', 'Gallego', '1991-05-09', 10000037),
(38, 'claveSegura38', '555-1038', '2020-03-08', 'cliente38@email.com', 'Cristina', 'Vega', '1986-03-27', 10000038),
(39, 'claveSegura39', '555-1039', '2020-03-09', 'cliente39@email.com', 'Adrián', 'Fuentes', '1975-09-14', 10000039),
(40, 'claveSegura40', '555-1040', '2020-03-10', 'cliente40@email.com', 'Berta', 'Cortés', '1994-12-08', 10000040),
(41, 'claveSegura41', '555-1041', '2020-03-11', 'cliente41@email.com', 'Samuel', 'Ramos', '1983-04-19', 10000041),
(42, 'claveSegura42', '555-1042', '2020-03-12', 'cliente42@email.com', 'Natalia', 'Soler', '1988-08-23', 10000042),
(43, 'claveSegura43', '555-1043', '2020-03-13', 'cliente43@email.com', 'Tony', 'Briceño', '1979-02-16', 10000043),
(44, 'claveSegura44', '555-1044', '2020-03-14', 'cliente44@email.com', 'Claudia', 'Benítez', '1997-06-30', 10000044),
(45, 'claveSegura45', '555-1045', '2020-03-15', 'cliente45@email.com', 'Jorge', 'Andrés', '1981-10-12', 10000045),
(46, 'claveSegura46', '555-1046', '2020-03-16', 'cliente46@email.com', 'Aurora', 'Blanco', '1990-01-25', 10000046),
(47, 'claveSegura47', '555-1047', '2020-03-17', 'cliente47@email.com', 'Guillermo', 'Rivas', '1976-07-18', 10000047),
(48, 'claveSegura48', '555-1048', '2020-03-18', 'cliente48@email.com', 'Verónica', 'Sanz', '1985-11-29', 10000048),
(49, 'claveSegura49', '555-1049', '2020-03-19', 'cliente49@email.com', 'Iván', 'Aguilar', '1992-09-03', 10000049),
(50, 'claveSegura50', '555-1050', '2020-03-20', 'cliente50@email.com', 'Diana', 'Arroyo', '1987-05-14', 10000050),
(51, 'claveSegura51', '555-1051', '2020-04-01', 'cliente51@email.com', 'Sergio', 'Medina', '1978-12-22', 10000051),
(52, 'claveSegura52', '555-1052', '2020-04-02', 'cliente52@email.com', 'Lidia', 'Domínguez', '1995-04-07', 10000052),
(53, 'claveSegura53', '555-1053', '2020-04-03', 'cliente53@email.com', 'Emilio', 'Bravo', '1984-08-15', 10000053),
(54, 'claveSegura54', '555-1054', '2020-04-04', 'cliente54@email.com', 'Inés', 'Gallardo', '1991-02-28', 10000054),
(55, 'claveSegura55', '555-1055', '2020-04-05', 'cliente55@email.com', 'César', 'Calvo', '1979-06-11', 10000055),
(56, 'claveSegura56', '555-1056', '2020-04-06', 'cliente56@email.com', 'Rocío', 'Vidal', '1986-10-24', 10000056),
(57, 'claveSegura57', '555-1057', '2020-04-07', 'cliente57@email.com', 'Ángel', 'Méndez', '1993-03-17', 10000057),
(58, 'claveSegura58', '555-1058', '2020-04-08', 'cliente58@email.com', 'Esther', 'Carrasco', '1980-07-30', 10000058),
(59, 'claveSegura59', '555-1059', '2020-04-09', 'cliente59@email.com', 'Félix', 'Prieto', '1996-01-12', 10000059),
(60, 'claveSegura60', '555-1060', '2020-04-10', 'cliente60@email.com', 'Lucía', 'Herrera', '1983-05-25', 10000060),
(61, 'claveSegura61', '555-1061', '2020-04-11', 'cliente61@email.com', 'Gonzalo', 'Montero', '1977-09-08', 10000061),
(62, 'claveSegura62', '555-1062', '2020-04-12', 'cliente62@email.com', 'Miriam', 'Giménez', '1994-11-19', 10000062),
(63, 'claveSegura63', '555-1063', '2020-04-13', 'cliente63@email.com', 'Raquel', 'Pardo', '1989-04-02', 10000063),
(64, 'claveSegura64', '555-1064', '2020-04-14', 'cliente64@email.com', 'Alfonso', 'Ríos', '1976-08-15', 10000064),
(65, 'claveSegura65', '555-1065', '2020-04-15', 'cliente65@email.com', 'Rhadames', 'Carmona', '1991-12-28', 10000065),
(66, 'claveSegura66', '555-1066', '2020-04-16', 'cliente66@email.com', 'José', 'Santiago', '1985-02-10', 10000066),
(67, 'claveSegura67', '555-1067', '2020-04-17', 'cliente67@email.com', 'Ester', 'Hidalgo', '1997-06-23', 10000067),
(68, 'claveSegura68', '555-1068', '2020-04-18', 'cliente68@email.com', 'Marcos', 'Palacios', '1982-10-06', 10000068),
(69, 'claveSegura69', '555-1069', '2020-04-19', 'cliente69@email.com', 'Julia', 'Santos', '1979-01-19', 10000069),
(70, 'claveSegura70', '555-1070', '2020-04-20', 'cliente70@email.com', 'Manuel', 'Lago', '1995-05-02', 10000070);

INSERT INTO Direccion(id,codigo_postal,calle,municipio,alias,nombre_edif)
VALUES
(1, 1010, 'Avenida Francisco de Miranda', 'Caracas', 'Edificio Parque Cristal', 'Torre Este'),
(2, 1050, 'Calle Guaicaipuro', 'Caracas', 'El Rosal', 'Centro San Ignacio'),
(3, 1060, 'Avenida Principal de Las Mercedes', 'Caracas', 'Zona Comercial', 'Galpón Mercedes'),
(4, 1070, 'Avenida Abraham Lincoln', 'Caracas', 'Cerca del CCCT', 'Torre Lincoln'),
(5, 1080, 'Calle California con Jalisco', 'Caracas', 'Urbanización Las Mercedes', 'Edificio California'),
(6, 4001, 'Avenida 8 (Santa Rita)', 'Maracaibo', 'Sector Santa Rita', 'Centro Plaza'),
(7, 4002, 'Calle 77 entre Av. 16 y 17', 'Maracaibo', 'Cerca de la Vereda del Lago', 'Edificio Don Andrés'),
(8, 4005, 'Avenida 15 (Delicias)', 'Maracaibo', 'Zona Industrial', 'Galpón Los Haticos'),
(9, 2001, 'Avenida Bolívar Norte', 'Valencia', 'Frente a Plaza Valencia', 'Torre Bolívar'),
(10, 2005, 'Calle 100 (Avenida Lara)', 'Valencia', 'Urbanización El Viñedo', 'Centro Comercial Viñedo'),
(11, 2101, 'Avenida Las Delicias', 'Maracay', 'Sector Las Delicias', 'Edificio Don Carlos'),
(12, 2103, 'Calle Mariño', 'Maracay', 'Centro Ciudad', 'Torre Central'),
(13, 3001, 'Plaza las Americas', 'Miranda', 'Casa Vinotinto', 'Casa 41'),
(14, 6301, 'Avenida Principal de Puerto Ordaz', 'Ciudad Guayana', 'Zona Industrial Matanzas', 'Galpón Alcasa'),
(15, 5201, 'Calle 5 de Julio', 'Mérida', 'Centro Histórico', 'Edificio Belensate'),
(16, 1020, 'Avenida Andrés Bello', 'Caracas', 'Torre La Previsora', 'Edificio La Previsora'),
(17, 4003, 'Avenida Circunvalación 2', 'Maracaibo', 'Sector La Lago', 'Centro Sambil'),
(18, 2102, 'Avenida Constitución', 'Maracay', 'Frente al Parque', 'Edificio Parque'),
(19, 3002, 'Calle 25 entre Carreras 19 y 20', 'Barquisimeto', 'Zona Comercial', 'Edificio Doral'),
(20, 6302, 'Avenida Las Américas', 'Ciudad Guayana', 'Urbanización Unare', 'Conjunto Residencial Unare');

INSERT INTO DireccionCliente(idCliente,idDireccion)
VALUES
-- Primeros 80 clientes con la misma dirección (ID 1)
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
(57, 1),
(58, 1),
(59, 1),
(60, 1),
(61, 1),
(62, 1),
(63, 1),
(64, 1),
(65, 1),
(66, 1),
(67, 1),
(68, 1),
(69, 1),
(70, 1),
(71, 1),
(72, 1),
(73, 1),
(74, 1),
(75, 1),
(76, 1),
(77, 1),
(78, 1),
(79, 1),
(80, 1),
(81, 2),
(82, 3),
(83, 4),
(84, 5),
(85, 6),
(86, 7),
(87, 8),
(88, 9),
(89, 10),
(90, 11),
(91, 12),
(92, 13),
(93, 14),
(94, 15),
(95, 16),
(96, 17),
(97, 18),
(98, 19),
(99, 20),
(100, 13);

INSERT INTO Repartidor(id,[password],telefono,fecha_registro,correo,nombre,apellido,fecha_nac,nro_documento,detalle_vehiculo,estado)
VALUES
(1, 'repartidor1pass', '412-555-5101', '2021-01-10', 'repartidor1@empresa.com', 'Carlos', 'Mendoza', '1990-05-15', 25551001, 'Moto Honda CB125F - Placa ABC123', 'Activo'),
(2, 'repartidor2pass', '412-555-5102', '2021-01-15', 'repartidor2@empresa.com', 'Luis', 'González', '1988-07-22', 25551002, 'Moto Yamaha YBR125 - Placa XYZ456', 'Activo'),
(3, 'repartidor3pass', '412-555-5103', '2021-02-05', 'repartidor3@empresa.com', 'Ana', 'Pérez', '1992-03-18', 25551003, 'Bicicleta eléctrica - Modelo E-X12', 'Activo'),
(4, 'repartidor4pass', '412-555-5104', '2021-02-20', 'repartidor4@empresa.com', 'Miguel', 'Rodríguez', '1985-11-30', 25551004, 'Moto Suzuki GN125 - Placa DEF789', 'Activo'),
(5, 'repartidor5pass', '412-555-5105', '2021-03-12', 'repartidor5@empresa.com', 'Sofía', 'Martínez', '1993-09-08', 25551005, 'Scooter Vespa Primavera - Placa GHI012', 'Activo'),
(6, 'repartidor6pass', '412-555-5106', '2021-04-01', 'repartidor6@empresa.com', 'Jorge', 'López', '1987-12-25', 25551006, 'Moto Bajaj Boxer 150 - Placa JKL345', 'Activo'),
(7, 'repartidor7pass', '412-555-5107', '2021-04-18', 'repartidor7@empresa.com', 'Elena', 'García', '1989-06-18', 25551007, 'Bicicleta de montaña - Modelo Trek X1', 'Activo'),
(8, 'repartidor8pass', '412-555-5108', '2021-05-05', 'repartidor8@empresa.com', 'Pedro', 'Sánchez', '1991-04-05', 25551008, 'Moto KTM Duke 125 - Placa MNO678', 'Activo'),
(9, 'repartidor9pass', '412-555-5109', '2021-05-22', 'repartidor9@empresa.com', 'Laura', 'Díaz', '1986-08-12', 25551009, 'Scooter Yamaha NMAX - Placa PQR901', 'Activo'),
(10, 'repartidor10pass', '412-555-5110', '2021-06-10', 'repartidor10@empresa.com', 'Diego', 'Fernández', '1984-10-30', 25551010, 'Moto Harley Davidson Street 500 - Placa STU234', 'Activo'),
(11, 'repartidor11pass', '412-555-5111', '2021-07-01', 'repartidor11@empresa.com', 'María', 'Romero', '1995-01-14', 25551011, 'Bicicleta eléctrica - Modelo E-MTB', 'Activo'),
(12, 'repartidor12pass', '412-555-5112', '2021-07-19', 'repartidor12@empresa.com', 'Andrés', 'Álvarez', '1983-07-19', 25551012, 'Moto BMW G310R - Placa VWX567', 'Activo'),
(13, 'repartidor13pass', '412-555-5113', '2021-08-05', 'repartidor13@empresa.com', 'Patricia', 'Torres', '1994-02-28', 25551013, 'Scooter Piaggio Liberty - Placa YZA890', 'Activo'),
(14, 'repartidor14pass', '412-555-5114', '2021-08-22', 'repartidor14@empresa.com', 'Ricardo', 'Jiménez', '1982-05-22', 25551014, 'Moto Kawasaki Z400 - Placa BCD123', 'Activo'),
(15, 'repartidor15pass', '412-555-5115', '2021-09-10', 'repartidor15@empresa.com', 'Carmen', 'Ruiz', '1996-12-08', 25551015, 'Bicicleta plegable - Modelo Brompton', 'Activo'),
(16, 'repartidor16pass', '412-555-5116', '2021-09-28', 'repartidor16@empresa.com', 'Fernando', 'Navarro', '1981-03-17', 25551016, 'Moto Honda SH150i - Placa EFG456', 'Inactivo'),
(17, 'repartidor17pass', '412-555-5117', '2021-10-15', 'repartidor17@empresa.com', 'Teresa', 'Hernández', '1980-09-14', 25551017, 'Scooter Kymco Like 125 - Placa HIJ789', 'Inactivo'),
(18, 'repartidor18pass', '412-555-5118', '2021-11-02', 'repartidor18@empresa.com', 'Raúl', 'Gil', '1979-06-23', 25551018, 'Moto Yamaha MT-07 - Placa KLM012', 'Inactivo'),
(19, 'repartidor19pass', '412-555-5119', '2021-11-20', 'repartidor19@empresa.com', 'Beatriz', 'Serrano', '1978-08-04', 25551019, 'Bicicleta eléctrica - Modelo E-City', 'Inactivo'),
(20, 'repartidor20pass', '412-555-5120', '2021-12-08', 'repartidor20@empresa.com', 'Samson', 'Belisario', '1997-03-12', 25551020, 'Moto Ducati Scrambler - Placa NOP345', 'Inactivo');

INSERT INTO ClienteRepartidor(idCliente,idRepartidor,fecha,puntaje,comentario)
VALUES
-- Clientes calificando a repartidores (usando IDs de repartidores 1-20)
(71, 1, '2022-01-15', 5, 'Excelente servicio, muy puntual'),
(72, 2, '2022-01-18', 4, 'Buen servicio pero llegó un poco tarde'),
(73, 3, '2022-01-20', 5, 'Muy amable y cuidadoso con el pedido'),
(74, 4, '2022-01-22', 3, 'El repartido se equivocó de dirección al principio'),
(75, 5, '2022-01-25', 5, 'Servicio perfecto, muy profesional'),
(76, 6, '2022-01-28', 4, 'Buen servicio en general'),
(77, 7, '2022-02-01', 2, 'Pedido llegó frío y tarde'),
(78, 8, '2022-02-05', 5, 'Increíblemente rápido y amable'),
(79, 9, '2022-02-10', 4, 'Buen servicio, solo un pequeño retraso'),
(80, 10, '2022-02-15', 5, 'El mejor repartidor que he tenido'),
-- Relaciones adicionales para completar variedad
(81, 11, '2022-02-18', 3, 'Servicio regular, nada especial'),
(82, 12, '2022-02-20', 5, 'Muy profesional y cuidadoso'),
(83, 13, '2022-02-22', 4, 'Buen trato y entrega rápida'),
(84, 14, '2022-02-25', 1, 'Pedido llegó incompleto y muy tarde'),
(85, 15, '2022-03-01', 5, 'Siempre puntual y con buena actitud'),
(86, 16, '2022-03-05', 2, 'No siguió instrucciones de entrega'),
(87, 17, '2022-03-10', 4, 'Buen servicio en general'),
(88, 18, '2022-03-15', 3, 'Demora en la entrega pero fue amable'),
(89, 19, '2022-03-20', 5, 'Excelente trato y muy rápido'),
(90, 20, '2022-03-25', 4, 'Buen servicio, solo un pequeño detalle'),
-- Relaciones adicionales Cliente-Repartidor (utilizando IDs de clientes 21-50)
(21, 3, '2022-04-02', 4, 'Buen servicio, empaque un poco maltratado'),
(22, 5, '2022-04-05', 5, 'Excelente atención, comida perfecta'),
(23, 7, '2022-04-08', 3, 'Equivocó bebida pero fue amable'),
(24, 9, '2022-04-11', 4, 'Puntual y con buena actitud'),
(25, 11, '2022-04-14', 2, 'Pedido incompleto, no respondió'),
(26, 13, '2022-04-17', 5, 'Servicio impecable'),
(27, 15, '2022-04-20', 4, 'Rápido pero olvidó cubiertos'),
(28, 17, '2022-04-23', 1, 'Pedido equivocado y frío'),
(29, 19, '2022-04-26', 5, 'Muy detallista'),
(30, 2, '2022-04-29', 3, 'Demora por tráfico'),
(31, 4, '2022-05-03', 5, 'Comida caliente y bien empacada'),
(32, 6, '2022-05-06', 4, 'Buen trato pero manejaba rápido'),
(33, 8, '2022-05-09', 2, 'No siguió instrucciones'),
(34, 10, '2022-05-12', 5, 'Perfecto para evento'),
(35, 12, '2022-05-15', 3, 'Olvidó salsas'),
(36, 14, '2022-05-18', 4, 'Educado y cuidadoso'),
(37, 16, '2022-05-21', 1, '1 hora tarde y frío'),
(38, 18, '2022-05-24', 5, 'Trajo extras no pedidos'),
(39, 20, '2022-05-27', 4, 'Buen servicio general'),
(40, 1, '2022-05-30', 3, 'Servicio regular'),
(41, 3, '2022-06-03', 5, 'Manejó bien pedido complicado'),
(42, 5, '2022-06-06', 4, 'Cumplió con lo solicitado'),
(43, 7, '2022-06-09', 2, 'Mala actitud'),
(44, 9, '2022-06-12', 5, 'Servicio premium'),
(45, 11, '2022-06-15', 3, 'Demora injustificada'),
(46, 13, '2022-06-18', 4, 'Entrega eficiente'),
(47, 15, '2022-06-21', 5, 'Atento a detalles'),
(48, 17, '2022-06-24', 1, 'Dirección equivocada'),
(49, 19, '2022-06-27', 5, 'Excepcional para cena'),
(50, 2, '2022-06-30', 4, 'Buen servicio');

INSERT INTO Pedido(id,cantidad_items,costo_envio,nota,tiempo_entrega,total)
VALUES
(1, 3, 2.50, 'Entregar en portería', 35, 28.75),
(2, 2, 2.00, 'Sin picante', 28, 19.99),
(3, 5, 3.00, 'Empaque para regalo', 45, 52.30),
(4, 1, 1.50, 'Llamar antes de llegar', 25, 12.49),
(5, 4, 2.75, 'Dejar con conserje', 38, 37.20),
(6, 2, 2.00, 'Extra servilletas', 30, 22.50),
(7, 3, 2.50, 'Sin cebolla', 32, 29.99),
(8, 1, 1.50, 'Urgente', 20, 15.25),
(9, 6, 3.50, 'Empaque sellado', 50, 68.40),
(10, 2, 2.00, 'Dejar en puerta', 27, 21.75),
(11, 4, 2.75, 'Poco picante', 40, 39.99),
(12, 1, 1.50, 'Sin ajo', 22, 13.20),
(13, 3, 2.50, 'Entregar a Sr. González', 34, 27.80),
(14, 5, 3.00, 'Empaque especial', 48, 55.60),
(15, 2, 2.00, 'Llamar al llegar', 29, 23.40),
(16, 1, 1.50, 'Sin gluten', 24, 14.99),
(17, 4, 2.75, 'Vegano', 42, 41.25),
(18, 3, 2.50, 'Dejar con recepción', 36, 31.70),
(19, 2, 2.00, 'Extra salsa', 31, 24.50),
(20, 6, 3.50, 'Cumpleaños', 55, 72.30),
(21, 1, 1.50, 'Sin sal', 23, 16.20),
(22, 3, 2.50, 'Entregar en oficina 302', 37, 32.99),
(23, 4, 2.75, 'Bien cocido', 43, 44.80),
(24, 2, 2.00, 'Sin lácteos', 33, 26.40),
(25, 1, 1.50, 'Aniversario', 26, 18.75),
(26, 5, 3.00, 'Empaque resistente', 52, 60.20),
(27, 3, 2.50, 'Dejar en buzón', 39, 34.50),
(28, 2, 2.00, 'Extra queso', 34, 25.80),
(29, 4, 2.75, 'Para llevar', 46, 47.90),
(30, 1, 1.50, 'Sin huevo', 28, 17.60), 
(31, 3, 2.50, 'Entregar a Sra. Martínez', 40, 33.25),
(32, 2, 2.00, 'Sin mostaza', 35, 27.80),
(33, 4, 2.75, 'Boda', 50, 56.40),
(34, 1, 1.50, 'Dejar con vecino', 30, 19.99),
(35, 5, 3.00, 'Empaque premium', 55, 64.70),
(36, 2, 2.00, 'Extra guacamole', 38, 29.50),
(37, 3, 2.50, 'Sin tomate', 42, 36.20),
(38, 1, 1.50, 'Urgente', 25, 21.30),
(39, 6, 3.50, 'Fiesta infantil', 60, 78.90),
(40, 2, 2.00, 'Dejar en garaje', 45, 30.75),
(41, 4, 2.75, 'Poco aceite', 52, 58.40),
(42, 1, 1.50, 'Sin especias', 32, 22.99),
(43, 3, 2.50, 'Entregar a Dr. López', 47, 41.80),
(44, 5, 3.00, 'Empaque corporativo', 58, 67.30),
(45, 2, 2.00, 'Llamar al celular', 40, 34.20),
(46, 1, 1.50, 'Sin azúcar', 28, 23.50),
(47, 4, 2.75, 'Vegetariano', 50, 53.60),
(48, 3, 2.50, 'Dejar en casillero', 45, 39.99),
(49, 2, 2.00, 'Extra limón', 38, 31.40),
(50, 6, 3.50, 'Reunión familiar', 65, 85.20),
(51, 1, 1.50, 'Sin vinagre', 30, 24.75),
(52, 3, 2.50, 'Entregar en departamento', 50, 43.60),
(53, 4, 2.75, 'Al punto', 55, 59.30),
(54, 2, 2.00, 'Sin gluten', 42, 37.80),
(55, 1, 1.50, 'Graduación', 35, 26.40),
(56, 5, 3.00, 'Empaque festivo', 60, 70.50),
(57, 3, 2.50, 'Dejar con seguridad', 52, 45.20),
(58, 2, 2.00, 'Extra picante', 45, 38.90),
(59, 4, 2.75, 'Para evento', 58, 62.40),
(60, 1, 1.50, 'Sin cebollín', 32, 27.30),
(61, 3, 2.50, 'Entregar a contabilidad', 55, 48.70),
(62, 2, 2.00, 'Sin apio', 45, 36.20),
(63, 4, 2.75, 'Baby shower', 60, 65.80),
(64, 1, 1.50, 'Dejar en mesa exterior', 38, 29.99),
(65, 5, 3.00, 'Empaque elegante', 65, 74.50),
(66, 2, 2.00, 'Extra aderezo', 50, 42.30),
(67, 3, 2.50, 'Sin zanahoria', 52, 47.60),
(68, 1, 1.50, 'Prioridad', 30, 25.40),
(69, 6, 3.50, 'Celebración empresarial', 70, 92.80),
(70, 2, 2.00, 'Dejar en cocina', 55, 45.70),
(71, 4, 2.75, 'Poco sal', 60, 63.20),
(72, 1, 1.50, 'Sin pimienta', 40, 34.99),
(73, 3, 2.50, 'Entregar a recepcionista', 58, 52.40),
(74, 5, 3.00, 'Empaque de lujo', 70, 81.60),
(75, 2, 2.00, 'Llamar al timbre', 52, 46.80),
(76, 1, 1.50, 'Sin colorantes', 35, 30.20),
(77, 4, 2.75, 'Vegano estricto', 62, 67.90),
(78, 3, 2.50, 'Dejar en jardín', 55, 50.30),
(79, 2, 2.00, 'Extra hierbas', 48, 43.60),
(80, 6, 3.50, 'Fiesta de compromiso', 75, 98.40),
(81, 1, 1.50, 'Sin conservantes', 42, 38.50),
(82, 3, 2.50, 'Entregar en sala de juntas', 65, 59.20),
(83, 4, 2.75, 'Poco cocido', 70, 72.80),
(84, 2, 2.00, 'Sin lactosa', 55, 49.30),
(85, 1, 1.50, 'Bautizo', 45, 41.20),
(86, 5, 3.00, 'Empaque rústico', 75, 88.70),
(87, 3, 2.50, 'Dejar con mayordomo', 65, 62.40),
(88, 2, 2.00, 'Extra especias', 58, 54.80),
(89, 4, 2.75, 'Para buffet', 72, 78.30),
(90, 1, 1.50, 'Sin perejil', 40, 36.70),
(91, 3, 2.50, 'Entregar en área de fumadores', 60, 55.20),
(92, 2, 2.00, 'Sin cilantro', 50, 45.80),
(93, 4, 2.75, 'Despedida de soltero', 65, 71.40),
(94, 1, 1.50, 'Dejar en mesa de regalos', 45, 42.30),
(95, 5, 3.00, 'Empaque temático', 70, 82.60),
(96, 2, 2.00, 'Extra aceitunas', 55, 51.20),
(97, 3, 2.50, 'Sin berenjena', 58, 54.80),
(98, 1, 1.50, 'Express', 35, 32.40),
(99, 6, 3.50, 'Convención anual', 80, 105.20),
(100, 2, 2.00, 'Dejar en quincho', 60, 58.70),
(101, 4, 2.75, 'Poco dulce', 65, 70.80),
(102, 1, 1.50, 'Sin almidón', 45, 43.90),
(103, 3, 2.50, 'Entregar a gerencia', 70, 65.40),
(104, 5, 3.00, 'Empaque ejecutivo', 75, 89.50),
(105, 2, 2.00, 'Llamar al portero', 60, 59.20),
(106, 1, 1.50, 'Sin levadura', 40, 38.70),
(107, 4, 2.75, 'Crudivegano', 70, 76.40),
(108, 3, 2.50, 'Dejar en terraza', 65, 63.80),
(109, 2, 2.00, 'Extra condimentos', 55, 53.20),
(110, 6, 3.50, 'Fiesta de inauguración', 85, 112.30),
(111, 1, 1.50, 'Sin gluten', 45, 44.50),
(112, 3, 2.50, 'Entregar en salón principal', 75, 72.80),
(113, 4, 2.75, 'Sellado al vacío', 80, 85.70),
(114, 2, 2.00, 'Sin semillas', 60, 59.30),
(115, 1, 1.50, 'Primera comunión', 50, 49.80),
(116, 5, 3.00, 'Empaque institucional', 80, 94.20),
(117, 3, 2.50, 'Dejar con chef', 70, 68.40),
(118, 2, 2.00, 'Extra vinagre', 60, 61.70),
(119, 4, 2.75, 'Para catering', 85, 92.50),
(120, 1, 1.50, 'Sin mostaza', 45, 47.20),
(121, 3, 2.50, 'Entregar en barra', 70, 66.80),
(122, 2, 2.00, 'Sin orégano', 55, 54.30),
(123, 4, 2.75, 'Fiesta de egresados', 75, 83.40),
(124, 1, 1.50, 'Dejar en comedor', 50, 51.70),
(125, 5, 3.00, 'Empaque ecológico', 80, 97.50),
(126, 2, 2.00, 'Extra jalapeños', 60, 62.80),
(127, 3, 2.50, 'Sin pimentón', 65, 64.20),
(128, 1, 1.50, 'Prioritario', 40, 42.50),
(129, 6, 3.50, 'Conferencia internacional', 90, 118.70),
(130, 2, 2.00, 'Dejar en área VIP', 70, 72.40),
(131, 4, 2.75, 'Poco ácido', 75, 81.20),
(132, 1, 1.50, 'Sin curry', 50, 53.80),
(133, 3, 2.50, 'Entregar a director', 80, 78.60),
(134, 5, 3.00, 'Empaque institucional', 85, 102.30),
(135, 2, 2.00, 'Llamar al asistente', 70, 74.20),
(136, 1, 1.50, 'Sin nueces', 45, 48.70),
(137, 4, 2.75, 'Raw vegan', 80, 88.40),
(138, 3, 2.50, 'Dejar en lounge', 75, 77.80),
(139, 2, 2.00, 'Extra especias', 65, 69.20),
(140, 6, 3.50, 'Gala benéfica', 95, 125.60);

INSERT INTO Factura(numero,fecha_emision,sub_total,porcentajeIva,montoIVA,monto_total,idPedido)
VALUES
(20230001, '2023-07-10', 25.00, 16, 4.00, 29.00, 1),
(20230002, '2023-07-11', 18.50, 16, 2.96, 21.46, 2),
(20230003, '2023-07-12', 42.00, 16, 6.72, 48.72, 3),
(20230004, '2023-07-13', 15.75, 16, 2.52, 18.27, 4),
(20230005, '2023-07-14', 30.25, 16, 4.84, 35.09, 5),
(20230006, '2023-07-15', 22.00, 16, 3.52, 25.52, 6),
(20230007, '2023-07-16', 28.50, 16, 4.56, 33.06, 7),
(20230008, '2023-07-17', 14.80, 16, 2.37, 17.17, 8),
(20230009, '2023-07-18', 55.00, 16, 8.80, 63.80, 9),
(20230010, '2023-07-19', 20.00, 16, 3.20, 23.20, 10),
(20230011, '2023-07-20', 32.50, 16, 5.20, 37.70, 11),
(20230012, '2023-07-21', 12.50, 16, 2.00, 14.50, 12),
(20230013, '2023-07-22', 26.00, 16, 4.16, 30.16, 13),
(20230014, '2023-07-23', 45.00, 16, 7.20, 52.20, 14),
(20230015, '2023-07-24', 19.00, 16, 3.04, 22.04, 15),
(20230016, '2023-07-25', 13.50, 16, 2.16, 15.66, 16),
(20230017, '2023-07-26', 35.00, 16, 5.60, 40.60, 17),
(20230018, '2023-07-27', 24.00, 16, 3.84, 27.84, 18),
(20230019, '2023-07-28', 21.50, 16, 3.44, 24.94, 19),
(20230020, '2023-07-29', 60.00, 16, 9.60, 69.60, 20),
(20230021, '2023-07-30', 14.00, 16, 2.24, 16.24, 21),
(20230022, '2023-07-31', 27.50, 16, 4.40, 31.90, 22),
(20230023, '2023-08-01', 38.00, 16, 6.08, 44.08, 23),
(20230024, '2023-08-02', 22.50, 16, 3.60, 26.10, 24),
(20230025, '2023-08-03', 16.00, 16, 2.56, 18.56, 25),
(20230026, '2023-08-04', 50.00, 16, 8.00, 58.00, 26),
(20230027, '2023-08-05', 28.00, 16, 4.48, 32.48, 27),
(20230028, '2023-08-06', 21.00, 16, 3.36, 24.36, 28),
(20230029, '2023-08-07', 40.00, 16, 6.40, 46.40, 29),
(20230030, '2023-08-08', 15.00, 16, 2.40, 17.40, 30),
(20230031, '2023-08-09', 26.00, 16, 4.16, 30.16, 31),
(20230032, '2023-08-10', 19.00, 16, 3.04, 22.04, 32),
(20230033, '2023-08-11', 43.00, 16, 6.88, 49.88, 33),
(20230034, '2023-08-12', 16.00, 16, 2.56, 18.56, 34),
(20230035, '2023-08-13', 31.00, 16, 4.96, 35.96, 35),
(20230036, '2023-08-14', 23.00, 16, 3.68, 26.68, 36),
(20230037, '2023-08-15', 29.00, 16, 4.64, 33.64, 37),
(20230038, '2023-08-16', 15.00, 16, 2.40, 17.40, 38),
(20230039, '2023-08-17', 56.00, 16, 8.96, 64.96, 39),
(20230040, '2023-08-18', 21.00, 16, 3.36, 24.36, 40),
(20230041, '2023-08-19', 33.00, 16, 5.28, 38.28, 41),
(20230042, '2023-08-20', 13.00, 16, 2.08, 15.08, 42),
(20230043, '2023-08-21', 27.00, 16, 4.32, 31.32, 43),
(20230044, '2023-08-22', 46.00, 16, 7.36, 53.36, 44),
(20230045, '2023-08-23', 20.00, 16, 3.20, 23.20, 45),
(20230046, '2023-08-24', 14.00, 16, 2.24, 16.24, 46),
(20230047, '2023-08-25', 36.00, 16, 5.76, 41.76, 47),
(20230048, '2023-08-26', 25.00, 16, 4.00, 29.00, 48),
(20230049, '2023-08-27', 22.00, 16, 3.52, 25.52, 49),
(20230050, '2023-08-28', 61.00, 16, 9.76, 70.76, 50),
(20240051, '2024-01-05', 27.00, 16, 4.32, 31.32, 51),
(20240052, '2024-01-10', 20.00, 16, 3.20, 23.20, 52),
(20240053, '2024-01-15', 44.00, 16, 7.04, 51.04, 53),
(20240054, '2024-01-20', 17.00, 16, 2.72, 19.72, 54),
(20240055, '2024-01-25', 32.00, 16, 5.12, 37.12, 55),
(20240056, '2024-02-01', 24.00, 16, 3.84, 27.84, 56),
(20240057, '2024-02-05', 30.00, 16, 4.80, 34.80, 57),
(20240058, '2024-02-10', 16.00, 16, 2.56, 18.56, 58),
(20240059, '2024-02-15', 57.00, 16, 9.12, 66.12, 59),
(20240060, '2024-02-20', 22.00, 16, 3.52, 25.52, 60),
(20240061, '2024-02-25', 34.00, 16, 5.44, 39.44, 61),
(20240062, '2024-03-01', 14.00, 16, 2.24, 16.24, 62),
(20240063, '2024-03-05', 28.00, 16, 4.48, 32.48, 63),
(20240064, '2024-03-10', 47.00, 16, 7.52, 54.52, 64),
(20240065, '2024-03-15', 21.00, 16, 3.36, 24.36, 65),
(20240066, '2024-03-20', 15.00, 16, 2.40, 17.40, 66),
(20240067, '2024-03-25', 37.00, 16, 5.92, 42.92, 67),
(20240068, '2024-04-01', 26.00, 16, 4.16, 30.16, 68),
(20240069, '2024-04-05', 23.00, 16, 3.68, 26.68, 69),
(20240070, '2024-04-10', 62.00, 16, 9.92, 71.92, 70),
(20240071, '2024-04-15', 28.00, 16, 4.48, 32.48, 71),
(20240072, '2024-04-20', 21.00, 16, 3.36, 24.36, 72),
(20240073, '2024-04-25', 45.00, 16, 7.20, 52.20, 73),
(20240074, '2024-05-01', 18.00, 16, 2.88, 20.88, 74),
(20240075, '2024-05-05', 33.00, 16, 5.28, 38.28, 75),
(20240076, '2024-05-10', 25.00, 16, 4.00, 29.00, 76),
(20240077, '2024-05-15', 31.00, 16, 4.96, 35.96, 77),
(20240078, '2024-05-20', 17.00, 16, 2.72, 19.72, 78),
(20240079, '2024-05-25', 58.00, 16, 9.28, 67.28, 79),
(20240080, '2024-06-01', 23.00, 16, 3.68, 26.68, 80),
(20240081, '2024-06-05', 35.00, 16, 5.60, 40.60, 81),
(20240082, '2024-06-10', 15.50, 16, 2.48, 17.98, 82),
(20240083, '2024-06-15', 29.00, 16, 4.64, 33.64, 83),
(20240084, '2024-06-20', 48.00, 16, 7.68, 55.68, 84),
(20240085, '2024-06-25', 22.50, 16, 3.60, 26.10, 85),
(20240086, '2024-07-01', 16.50, 16, 2.64, 19.14, 86),
(20240087, '2024-07-05', 38.00, 16, 6.08, 44.08, 87),
(20240088, '2024-07-10', 27.00, 16, 4.32, 31.32, 88),
(20240089, '2024-07-15', 24.50, 16, 3.92, 28.42, 89),
(20240090, '2024-07-20', 63.00, 16, 10.08, 73.08, 90),
(20240091, '2024-07-25', 29.50, 16, 4.72, 34.22, 91),
(20240092, '2024-08-01', 22.75, 16, 3.64, 26.39, 92),
(20240093, '2024-08-05', 46.50, 16, 7.44, 53.94, 93),
(20240094, '2024-08-10', 19.25, 16, 3.08, 22.33, 94),
(20240095, '2024-08-15', 34.50, 16, 5.52, 40.02, 95),
(20240096, '2024-08-20', 26.25, 16, 4.20, 30.45, 96),
(20240097, '2024-08-25', 32.75, 16, 5.24, 37.99, 97),
(20240098, '2024-09-01', 18.75, 16, 3.00, 21.75, 98),
(20240099, '2024-09-05', 59.50, 16, 9.52, 69.02, 99),
(20240100, '2024-09-10', 24.25, 16, 3.88, 28.13, 100),
(20250101, '2025-01-15', 30.00, 16, 4.80, 34.80, 101),
(20250102, '2025-01-20', 22.25, 16, 3.56, 25.81, 102),
(20250103, '2025-01-25', 47.50, 16, 7.60, 55.10, 103),
(20250104, '2025-02-01', 19.75, 16, 3.16, 22.91, 104),
(20250105, '2025-02-05', 35.25, 16, 5.64, 40.89, 105),
(20250106, '2025-02-10', 26.50, 16, 4.24, 30.74, 106),
(20250107, '2025-02-15', 33.00, 16, 5.28, 38.28, 107),
(20250108, '2025-02-20', 18.25, 16, 2.92, 21.17, 108),
(20250109, '2025-02-25', 60.00, 16, 9.60, 69.60, 109),
(20250110, '2025-03-01', 25.50, 16, 4.08, 29.58, 110),
(20250111, '2025-03-05', 36.75, 16, 5.88, 42.63, 111),
(20250112, '2025-03-10', 16.75, 16, 2.68, 19.43, 112),
(20250113, '2025-03-15', 31.25, 16, 5.00, 36.25, 113),
(20250114, '2025-03-20', 49.50, 16, 7.92, 57.42, 114),
(20250115, '2025-03-25', 23.75, 16, 3.80, 27.55, 115),
(20250116, '2025-04-01', 17.25, 16, 2.76, 20.01, 116),
(20250117, '2025-04-05', 39.00, 16, 6.24, 45.24, 117),
(20250118, '2025-04-10', 28.50, 16, 4.56, 33.06, 118),
(20250119, '2025-04-15', 25.75, 16, 4.12, 29.87, 119),
(20250120, '2025-04-20', 64.00, 16, 10.24, 74.24, 120),
(20250121, '2025-04-25', 30.25, 16, 4.84, 35.09, 121),
(20250122, '2025-05-01', 23.50, 16, 3.76, 27.26, 122),
(20250123, '2025-05-05', 48.00, 16, 7.68, 55.68, 123),
(20250124, '2025-05-10', 20.50, 16, 3.28, 23.78, 124),
(20250125, '2025-05-15', 36.00, 16, 5.76, 41.76, 125),
(20250126, '2025-05-20', 27.75, 16, 4.44, 32.19, 126),
(20250127, '2025-05-25', 34.50, 16, 5.52, 40.02, 127),
(20250128, '2025-06-01', 19.50, 16, 3.12, 22.62, 128),
(20250129, '2025-06-05', 61.50, 16, 9.84, 71.34, 129),
(20250130, '2025-06-10', 26.00, 16, 4.16, 30.16, 130),
(20250131, '2025-06-15', 38.25, 16, 6.12, 44.37, 131),
(20250132, '2025-06-20', 17.50, 16, 2.80, 20.30, 132),
(20250133, '2025-06-25', 32.75, 16, 5.24, 37.99, 133),
(20250134, '2025-07-01', 50.25, 16, 8.04, 58.29, 134),
(20250135, '2025-07-05', 24.50, 16, 3.92, 28.42, 135),
(20250136, '2025-07-10', 18.00, 16, 2.88, 20.88, 136),
(20250137, '2025-07-15', 40.50, 16, 6.48, 46.98, 137),
(20250138, '2025-07-20', 29.25, 16, 4.68, 33.93, 138),
(20250139, '2025-07-25', 26.50, 16, 4.24, 30.74, 139),
(20250140, '2025-07-30', 65.00, 16, 10.40, 75.40, 140);

INSERT INTO ClientePedido (idCliente, idPedido, fecha) 
VALUES
(15, 1, '2023-07-10'),
(42, 2, '2023-07-11'),
(88, 3, '2023-07-12'),
(23, 4, '2023-07-13'),
(67, 5, '2023-07-14'),
(91, 6, '2023-07-15'),
(34, 7, '2023-07-16'),
(56, 8, '2023-07-17'),
(12, 9, '2023-07-18'),
(79, 10, '2023-07-19'),
(45, 11, '2023-07-20'),
(98, 12, '2023-07-21'),
(31, 13, '2023-07-22'),
(63, 14, '2023-07-23'),
(17, 15, '2023-07-24'),
(82, 16, '2023-07-25'),
(29, 17, '2023-07-26'),
(74, 18, '2023-07-27'),
(51, 19, '2023-07-28'),
(5, 20, '2023-07-29'),
(93, 21, '2023-07-30'),
(38, 22, '2023-07-31'),
(66, 23, '2023-08-01'),
(19, 24, '2023-08-02'),
(87, 25, '2023-08-03'),
(22, 26, '2023-08-04'),
(59, 27, '2023-08-05'),
(43, 28, '2023-08-06'),
(76, 29, '2023-08-07'),
(8, 30, '2023-08-08'),
(95, 31, '2023-08-09'),
(27, 32, '2023-08-10'),
(61, 33, '2023-08-11'),
(14, 34, '2023-08-12'),
(72, 35, '2023-08-13'),
(39, 36, '2023-08-14'),
(84, 37, '2023-08-15'),
(53, 38, '2023-08-16'),
(21, 39, '2023-08-17'),
(68, 40, '2023-08-18'),
(47, 41, '2023-08-19'),
(99, 42, '2023-08-20'),
(32, 43, '2023-08-21'),
(77, 44, '2023-08-22'),
(11, 45, '2023-08-23'),
(54, 46, '2023-08-24'),
(89, 47, '2023-08-25'),
(26, 48, '2023-08-26'),
(62, 49, '2023-08-27'),
(3, 50, '2023-08-28');

INSERT INTO RepartidorPedido (idRepartidor, idPedido, tiempo_entrega) 
VALUES
(5, 23, 32),
(12, 145, 28),
(88, 67, 45),
(34, 12, 38),
(76, 89, 25),
(19, 134, 50),
(42, 56, 22),
(93, 78, 33),
(27, 112, 41),
(63, 45, 29),
(8, 99, 36),
(51, 23, 31),
(97, 148, 27),
(14, 76, 44),
(39, 34, 39),
(72, 121, 23),
(3, 58, 47),
(45, 92, 30),
(81, 13, 34),
(22, 137, 42);

INSERT INTO PedidoDetalle (id, cantidad, nota, total, idPedido, idPlato) 
VALUES
(1, 2, 'Sin gluten por favor', 17.00, 23, 5),   -- Saltimbocca alla Romana
(2, 1, 'Extra picante', 28.00, 145, 22),      -- Paella Valenciana
(3, 3, 'Bien cocido', 57.00, 67, 35),         -- Kebab Mixto
(4, 1, 'Sin cebolla', 15.50, 12, 3),          -- Spaghetti Carbonara
(5, 2, 'Para llevar', 36.00, 89, 47),         -- Pizza Margherita
(6, 1, 'Con limón extra', 18.00, 134, 30),    -- Ceviche Clásico
(7, 2, 'Poco picante', 34.00, 56, 27),        -- Butter Chicken
(8, 1, 'Punto medio', 25.00, 78, 39),         -- Bife de Chorizo
(9, 3, 'Sin piña', 37.50, 112, 13),           -- Tacos al Pastor
(10, 1, 'Fresco por favor', 18.00, 45, 7),    -- Sashimi de Salmón
(11, 2, 'Con papas fritas', 33.00, 99, 32),   -- Lomo Saltado
(12, 1, 'Con helado de vainilla', 8.50, 23, 58), -- Tarta de Manzana
(13, 2, 'Piel extra crujiente', 52.00, 148, 63), -- Pato Laqueado
(14, 1, 'Sin piña', 13.50, 76, 18),           -- Cerdo Agridulce
(15, 2, 'Con totopos extra', 16.00, 34, 12),  -- Guacamole Tradicional
(16, 1, 'Con pimentón aparte', 22.00, 121, 96), -- Pulpo a la Gallega
(17, 1, 'Con salsa aparte', 24.00, 58, 19),   -- Pato a la Naranja
(18, 1, 'Con panqueques extra', 28.00, 92, 113), -- Pato Pekín
(19, 2, 'Sin nueces', 38.00, 13, 112),       -- Chiles en Nogada
(20, 1, 'Con pan para mojar', 16.00, 137, 24), -- Gambas al Ajillo
(21, 2, 'Medio picante', 33.00, 64, 66),      -- Tikka Masala
(22, 1, 'Con huevo', 15.00, 105, 82),         -- Gyudon
(23, 3, 'Con miel aparte', 19.50, 53, 37),    -- Baklava
(24, 1, 'Con canela', 7.00, 97, 25),          -- Crema Catalana
(25, 2, 'Con repollo extra', 30.00, 126, 104), -- Tacos de Pescado
(26, 1, 'Sin jamón', 16.00, 71, 93),          -- Milanesa Napolitana
(27, 1, 'Poco chocolate', 16.00, 142, 83),    -- Mole Poblano
(28, 2, 'Caldo extra', 34.00, 29, 94),        -- Ramen Tonkotsu
(29, 1, 'Con arroz basmati', 14.50, 61, 115), -- Korma Vegetariano
(30, 1, 'Con vegetales al vapor', 20.00, 87, 78), -- Salmón Teriyaki
(31, 2, 'Pescado fresco', 40.00, 114, 117),   -- Ceviche Mixto
(32, 1, 'Bien marinadas', 22.00, 36, 70),     -- Costillas de Cordero
(33, 3, 'Derretido por favor', 36.00, 93, 40), -- Provoleta
(34, 1, 'Con chocolate rallado', 8.50, 128, 110), -- Cannoli Siciliano
(35, 2, 'Frío por favor', 13.00, 42, 97),     -- Kulfi de Pistacho
(36, 1, 'Con leche condensada', 8.00, 55, 90), -- Tres Leches
(37, 2, 'Con coco rallado', 12.00, 79, 101),  -- Majarete
(38, 1, 'Sin azúcar', 8.00, 103, 65),         -- Tarta de Santiago
(39, 1, 'Con pan fresco', 10.50, 117, 118),   -- Fattoush
(40, 2, 'Con salsa tártara', 19.00, 131, 119), -- Empanadas Arabes
(41, 1, 'Con frutillas', 9.00, 144, 120),     -- Dulce de Leche Pancakes
(42, 3, 'Con chocolate caliente', 21.00, 15, 62), -- Churros con Chocolate
(43, 1, 'Corriente por favor', 9.00, 28, 80), -- Chocolate Fondant
(44, 1, 'Con canela molida', 8.50, 91, 110),  -- Cannoli Siciliano
(45, 2, 'Con miel', 15.00, 37, 85),           -- Torrijas
(46, 3, 'Para regalo', 16.50, 66, 71),        -- Alfajores
(47, 1, 'Sin hielo', 5.00, 82, 87),           -- Chicha Morada
(48, 2, 'Con jengibre fresco', 12.00, 95, 109), -- Jugo de Remolacha
(49, 1, 'Sin gluten', 14.00, 107, 105),       -- Quinoa Bowl
(50, 1, 'Con vinagreta aparte', 11.50, 120, 106); -- Ensalada de Lentejas

INSERT INTO PedidoDetalleOpcionValor (idPedidoDetalle, idOpcionValor, idOpcion) 
VALUES
(1, 1, 1),    -- Saltimbocca con extra queso mozzarella
(2, 1, 22),   -- Paella en porción para 4 personas
(3, 3, 4),    -- Kebab Mixto con salsa extra picante
(4, 2, 3),    -- Spaghetti Carbonara con aguacate completo
(5, 1, 1),    -- Pizza Margherita con extra queso mozzarella
(6, 4, 4),    -- Ceviche Clásico con salsa extra picante
(7, 2, 28),   -- Butter Chicken poco picante
(8, 1, 31),   -- Bife de Chorizo poco hecho
(9, 1, 7),    -- Tacos al Pastor con pepinillos
(10, 1, 4),   -- Sashimi con salsa picante
(11, 1, 29),  -- Lomo Saltado bien cocido
(12, 1, 25),  -- Tarta de Manzana en menú niños
(13, 1, 24),  -- Pato Laqueado en porción del chef
(14, 1, 4),   -- Cerdo Agridulce con salsa picante
(15, 2, 2),   -- Guacamole con tocineta
(16, 1, 5),   -- Pulpo a la Gallega con cebolla caramelizada
(17, 1, 24),  -- Pato a la Naranja en porción del chef
(18, 1, 39),  -- Pato Pekín con 1/2 langosta
(19, 1, 36),  -- Chiles en Nogada con 2g de trufa
(20, 1, 5);   -- Gambas al Ajillo con cebolla caramelizada

INSERT INTO EstadoPedido (id, nombre, tiempo_promedio, descripcion) 
VALUES
(1, 'Pendiente', 5, 'Pedido registrado, esperando confirmación.'),
(2, 'Confirmado', 10, 'Pedido confirmado por el comercio.'),
(3, 'En Preparación', 20, 'El pedido está siendo preparado.'),
(4, 'Listo para Entrega', 2, 'El pedido está listo para ser entregado.'),
(5, 'En Camino', 30, 'El repartidor está en camino.'),
(6, 'Entregado', 0, 'El pedido fue entregado al cliente.'),
(7, 'Cancelado', 0, 'El pedido fue cancelado.'),
(8, 'Retrasado', 15, 'El pedido tiene un retraso inesperado.'),
(9, 'Devolución en Proceso', 5, 'El pedido está en proceso de devolución.'),
(10, 'Reembolsado', 0, 'El monto del pedido fue reembolsado.'),
(11, 'Rechazado por Comercio', 0, 'El comercio rechazó el pedido por falta de disponibilidad.'),
(12, 'Esperando Repartidor', 10, 'Pedido listo pero sin repartidor asignado aún.'),
(13, 'Reintento de Entrega', 20, 'Se está realizando un segundo intento de entrega.'),
(14, 'Programado', 60, 'Pedido programado para entrega futura.'),
(15, 'Error en Pago', 0, 'El pago no se procesó correctamente, pedido en revisión.');

INSERT INTO PedidoEstadoPedido (idPedido, idEstadoPedido, fecha_inicio) --FALTA COHERENCIA AAAAAAH (Juan 07/07/25)
VALUES
(1, 6, '2023-07-10'),  -- Pedido 1: Entregado
(2, 6, '2023-07-11'),  -- Pedido 2: Entregado
(3, 7, '2023-07-12'),  -- Pedido 3: Cancelado
(4, 6, '2023-07-13'),  -- Pedido 4: Entregado
(5, 6, '2023-07-14'),  -- Pedido 5: Entregado
(6, 6, '2023-07-15'),  -- Pedido 6: Entregado
(7, 6, '2023-07-16'),  -- Pedido 7: Entregado
(8, 6, '2023-07-17'),  -- Pedido 8: Entregado
(9, 6, '2023-07-18'),  -- Pedido 9: Entregado
(10, 6, '2023-07-19'), -- Pedido 10: Entregado
(11, 5, '2023-07-20'), -- Pedido 11: En Camino
(12, 3, '2023-07-21'), -- Pedido 12: En Preparación
(13, 4, '2023-07-22'), -- Pedido 13: Listo para Entrega
(14, 6, '2023-07-23'), -- Pedido 14: Entregado
(15, 6, '2023-07-24'), -- Pedido 15: Entregado
(16, 7, '2023-07-25'), -- Pedido 16: Cancelado
(17, 6, '2023-07-26'), -- Pedido 17: Entregado
(18, 6, '2023-07-27'), -- Pedido 18: Entregado
(19, 5, '2023-07-28'), -- Pedido 19: En Camino
(20, 6, '2023-07-29'), -- Pedido 20: Entregado
(21, 2, '2023-07-30'), -- Pedido 21: Confirmado
(22, 3, '2023-07-31'), -- Pedido 22: En Preparación
(23, 4, '2023-08-01'), -- Pedido 23: Listo para Entrega
(24, 6, '2023-08-02'), -- Pedido 24: Entregado
(25, 6, '2023-08-03'), -- Pedido 25: Entregado
(26, 7, '2023-08-04'), -- Pedido 26: Cancelado
(27, 6, '2023-08-05'), -- Pedido 27: Entregado
(28, 6, '2023-08-06'), -- Pedido 28: Entregado
(29, 5, '2023-08-07'), -- Pedido 29: En Camino
(30, 6, '2023-08-08'), -- Pedido 30: Entregado
(31, 1, '2023-08-09'), -- Pedido 31: Pendiente
(32, 2, '2023-08-10'), -- Pedido 32: Confirmado
(33, 3, '2023-08-11'), -- Pedido 33: En Preparación
(34, 4, '2023-08-12'), -- Pedido 34: Listo para Entrega
(35, 6, '2023-08-13'), -- Pedido 35: Entregado
(36, 6, '2023-08-14'), -- Pedido 36: Entregado
(37, 7, '2023-08-15'), -- Pedido 37: Cancelado
(38, 6, '2023-08-16'), -- Pedido 38: Entregado
(39, 6, '2023-08-17'), -- Pedido 39: Entregado
(40, 5, '2023-08-18'), -- Pedido 40: En Camino
(41, 6, '2023-08-19'), -- Pedido 41: Entregado
(42, 1, '2023-08-20'), -- Pedido 42: Pendiente
(43, 2, '2023-08-21'), -- Pedido 43: Confirmado
(44, 3, '2023-08-22'), -- Pedido 44: En Preparación
(45, 4, '2023-08-23'), -- Pedido 45: Listo para Entrega
(46, 6, '2023-08-24'), -- Pedido 46: Entregado
(47, 6, '2023-08-25'), -- Pedido 47: Entregado
(48, 7, '2023-08-26'), -- Pedido 48: Cancelado
(49, 6, '2023-08-27'), -- Pedido 49: Entregado
(50, 6, '2023-08-28'), -- Pedido 50: Entregado
(51, 6, '2023-08-29'), (52, 6, '2023-08-30'), (53, 7, '2023-08-31'), (54, 6, '2023-09-01'), 
(55, 6, '2023-09-02'), (56, 5, '2023-09-03'), (57, 6, '2023-09-04'), (58, 6, '2023-09-05'),
(59, 6, '2023-09-06'), (60, 7, '2023-09-07'), (61, 6, '2023-09-08'), (62, 6, '2023-09-09'),
(63, 5, '2023-09-10'), (64, 6, '2023-09-11'), (65, 2, '2023-09-12'), (66, 3, '2023-09-13'),
(67, 4, '2023-09-14'), (68, 6, '2023-09-15'), (69, 6, '2023-09-16'), (70, 7, '2023-09-17'),
(71, 6, '2023-09-18'), (72, 6, '2023-09-19'), (73, 5, '2023-09-20'), (74, 6, '2023-09-21'),
(75, 6, '2023-09-22'), (76, 1, '2023-09-23'), (77, 2, '2023-09-24'), (78, 3, '2023-09-25'),
(79, 4, '2023-09-26'), (80, 6, '2023-09-27'), (81, 6, '2023-09-28'), (82, 7, '2023-09-29'),
(83, 6, '2023-09-30'), (84, 6, '2023-10-01'), (85, 5, '2023-10-02'), (86, 6, '2023-10-03'),
(87, 6, '2023-10-04'), (88, 6, '2023-10-05'), (89, 2, '2023-10-06'), (90, 3, '2023-10-07'),
(91, 4, '2023-10-08'), (92, 6, '2023-10-09'), (93, 6, '2023-10-10'), (94, 7, '2023-10-11'),
(95, 6, '2023-10-12'), (96, 6, '2023-10-13'), (97, 5, '2023-10-14'), (98, 6, '2023-10-15'),
(99, 6, '2023-10-16'), (100, 6, '2023-10-17'), (101, 1, '2023-10-18'), (102, 2, '2023-10-19'),
(103, 3, '2023-10-20'), (104, 4, '2023-10-21'), (105, 6, '2023-10-22'), (106, 6, '2023-10-23'),
(107, 7, '2023-10-24'), (108, 6, '2023-10-25'), (109, 6, '2023-10-26'), (110, 5, '2023-10-27'),
(111, 6, '2023-10-28'), (112, 6, '2023-10-29'), (113, 6, '2023-10-30'), (114, 2, '2023-10-31'),
(115, 3, '2023-11-01'), (116, 4, '2023-11-02'), (117, 6, '2023-11-03'), (118, 6, '2023-11-04'),
(119, 7, '2023-11-05'), (120, 6, '2023-11-06'), (121, 6, '2023-11-07'), (122, 5, '2023-11-08'),
(123, 6, '2023-11-09'), (124, 6, '2023-11-10'), (125, 6, '2023-11-11'), (126, 1, '2023-11-12'),
(127, 2, '2023-11-13'), (128, 3, '2023-11-14'), (129, 4, '2023-11-15'), (130, 6, '2023-11-16'),
(131, 6, '2023-11-17'), (132, 7, '2023-11-18'), (133, 6, '2023-11-19'), (134, 6, '2023-11-20'),
(135, 5, '2023-11-21'), (136, 6, '2023-11-22'), (137, 6, '2023-11-23'), (138, 6, '2023-11-24'),
(139, 2, '2023-11-25'), (140, 3, '2023-11-26'), (141, 4, '2023-11-27'), (142, 6, '2023-11-28'),
(143, 6, '2023-11-29'), (144, 7, '2023-11-30'), (145, 6, '2023-12-01'), (146, 6, '2023-12-02'),
(147, 5, '2023-12-03'), (148, 6, '2023-12-04'), (149, 6, '2023-12-05'), (150, 6, '2023-12-06');