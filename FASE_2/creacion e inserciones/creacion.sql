-- Creacion de Base de datos
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'GourmetGo')
    CREATE DATABASE GourmetGo;

USE GourmetGo;

-- Creacion de tablas
CREATE TABLE Comercio (
			id int NOT NULL PRIMARY KEY,
			[password] varchar(256) NOT NULL,
			telefono varchar(256),
			fecha_registro DATE,
			correo varchar(256),
			nombre varchar(256) NOT NULL,
			ubicacion_fisica varchar(256),
			hora_apertura int CHECK (hora_apertura >= 0 AND hora_apertura <= 23),
			hora_cierre int,
			estaActivo BIT
);

CREATE TABLE Cocina (
			id INT NOT NULL PRIMARY KEY,
			nombre NVARCHAR(50) NOT NULL,
			descripcion NVARCHAR(255) NOT NULL
);
 
CREATE TABLE ComercioCocina (
			idComercio int NOT NULL,
			idCocina int NOT NULL,
			FOREIGN KEY (idComercio) REFERENCES Comercio(id),
			FOREIGN KEY (idCocina) REFERENCES Cocina(id),
			PRIMARY KEY (idComercio, idCocina)
);

CREATE TABLE Menu (
			id int NOT NULL PRIMARY KEY,
			nombre varchar(256) NOT NULL,
			descripcion varchar(256) NOT NULL,
			idComercio int NOT NULL,
			FOREIGN KEY (idComercio) REFERENCES Comercio(id)
);
 
CREATE TABLE Seccion (
			id int NOT NULL PRIMARY KEY,
			nombre varchar(256) NOT NULL,
			descripcion varchar(256) NOT NULL,
			idMenu int NOT NULL,
			FOREIGN KEY (idMenu) REFERENCES Menu(id)
);

CREATE TABLE Plato (
			id int NOT NULL PRIMARY KEY,
			nombre varchar(256) NOT NULL,
			orden int CHECK (orden > 0),
			cantidadDisponible int CHECK (cantidadDisponible >= 0),
			precio FLOAT CHECK (precio > 0),
			descripcion varchar(256) NOT NULL,
			idSeccion int NOT NULL,
			FOREIGN KEY (idSeccion) REFERENCES Seccion(id)
);

CREATE TABLE Opcion (
			id int NOT NULL PRIMARY KEY,
			nombre varchar(256) NOT NULL,
			descripcion varchar(256) NOT NULL
);

CREATE TABLE PlatoOpcion (
			idPlato int NOT NULL,
			idOpcion int NOT NULL,
			FOREIGN KEY (idPlato) REFERENCES Plato(id),
			FOREIGN KEY (idOpcion) REFERENCES Opcion(id),
			PRIMARY KEY (idPlato, idOpcion)
);

CREATE TABLE OpcionValor (
			id int NOT NULL,
			idOpcion int NOT NULL,
			nombre varchar(256) NOT NULL,
			precio_extra FLOAT CHECK (precio_extra >= 0),
			FOREIGN KEY (idOpcion) REFERENCES Opcion(id),
			PRIMARY KEY (id, idOpcion)
);

CREATE TABLE PlatoOpcionValor (
			idPlato int NOT NULL,
			idOpcionValor int NOT NULL,
			idOpcion int NOT NULL,
			FOREIGN KEY (idPlato) REFERENCES Plato(id),
			FOREIGN KEY (idOpcionValor, idOpcion) REFERENCES OpcionValor(id, idOpcion),
			PRIMARY KEY (idPlato, idOpcionValor, idOpcion)
);

CREATE TABLE Cliente (
			id int NOT NULL PRIMARY KEY,
			[password] varchar(256) NOT NULL,
			telefono varchar(256),
			fecha_registro DATE,
			correo varchar(256),
			nombre varchar(256) NOT NULL,
			apellido varchar(256),
			fecha_nac DATE,
			nro_documento int
);

CREATE TABLE ClienteConClienteReferido (
			idCliente int NOT NULL,
			idClienteReferido int NOT NULL,
			fecha_referido DATE,
			FOREIGN KEY (idCliente) REFERENCES Cliente(id),
			FOREIGN KEY (idClienteReferido) REFERENCES Cliente(id),
			PRIMARY KEY (idCliente, idClienteReferido, fecha_referido)
);

CREATE TABLE Direccion (
			id int NOT NULL PRIMARY KEY,
			codigo_postal int,
			calle varchar(256),
			municipio varchar(256),
			alias varchar(256),
			nombre_edif varchar(256)
);

CREATE TABLE DireccionCliente (
			idCliente int NOT NULL,
			idDireccion int NOT NULL,
			FOREIGN KEY (idCliente) REFERENCES Cliente(id),
			FOREIGN KEY (idDireccion) REFERENCES Direccion(id),
			PRIMARY KEY (idCliente, idDireccion)
);

CREATE TABLE Repartidor (
			id int NOT NULL PRIMARY KEY,
			[password] varchar(256) NOT NULL,
			telefono varchar(256),
			fecha_registro DATE,
			correo varchar(256),
			nombre varchar(256) NOT NULL,
			apellido varchar(256),
			fecha_nac DATE,
			nro_documento int,
			detalle_vehiculo varchar(256),
			estado varchar(256) CHECK (estado IN ('Activo', 'Inactivo'))
);

CREATE TABLE ClienteRepartidor (
			idCliente int NOT NULL,
			idRepartidor int NOT NULL,
			fecha DATE,
			puntaje int CHECK (puntaje > 0 AND puntaje <= 5 ),
			comentario varchar(256),
			FOREIGN KEY (idCliente) REFERENCES Cliente(id),
			FOREIGN KEY (idRepartidor) REFERENCES Repartidor(id),
			PRIMARY KEY (idCliente, idRepartidor, fecha)
);

CREATE TABLE Pedido (
			id int NOT NULL PRIMARY KEY,
			cantidad_items int CHECK (cantidad_items > 0),
			costo_envio FLOAT CHECK (costo_envio > 0),
			nota varchar(256),
			tiempo_entrega int CHECK (tiempo_entrega > 0),
			total FLOAT CHECK (total > 0)
);

CREATE TABLE ClientePedido (
			idCliente INT NOT NULL,
			idPedido INT NOT NULL,
			fecha DATETIME NOT NULL,
			PRIMARY KEY (idCliente, idPedido, fecha),
			FOREIGN KEY (idCliente) REFERENCES Cliente(id),
			FOREIGN KEY (idPedido) REFERENCES Pedido(id)
);

CREATE TABLE Factura (
			numero int NOT NULL PRIMARY KEY,
			fecha_emision DATE,
			sub_total FLOAT CHECK (sub_total > 0),
			porcentajeIva FLOAT CHECK (porcentajeIva > 0),
			montoIVA FLOAT CHECK (montoIVA > 0),
			monto_total FLOAT CHECK (monto_total > 0),
			idPedido int NOT NULL,
			FOREIGN KEY (idPedido) REFERENCES Pedido(id)
);

CREATE TABLE RepartidorPedido (
			idRepartidor int NOT NULL,
			idPedido int NOT NULL,
			tiempo_entrega int CHECK (tiempo_entrega > 0),
			FOREIGN KEY (idRepartidor) REFERENCES Repartidor(id),
			FOREIGN KEY (idPedido) REFERENCES Pedido(id),
			PRIMARY KEY (idRepartidor, idPedido)
);

CREATE TABLE PedidoDetalle (
			id int NOT NULL PRIMARY KEY,
			cantidad int CHECK (cantidad > 0),
			nota varchar(256),
			total FLOAT CHECK (total > 0),
			idPedido int NOT NULL,
			idPlato int NOT NULL,
			FOREIGN KEY (idPedido) REFERENCES Pedido(id),
			FOREIGN KEY (idPlato) REFERENCES Plato(id)
);

CREATE TABLE PedidoDetalleOpcionValor (
			idPedidoDetalle int NOT NULL,
			idOpcionValor int NOT NULL,
			idOpcion int NOT NULL,
			FOREIGN KEY (idPedidoDetalle) REFERENCES PedidoDetalle(id),
			FOREIGN KEY (idOpcionValor, idOpcion) REFERENCES OpcionValor(id, idOpcion),
			PRIMARY KEY (idPedidoDetalle, idOpcionValor, idOpcion)
);

CREATE TABLE EstadoPedido (
			id INT PRIMARY KEY,
			nombre NVARCHAR(50) NOT NULL,
			tiempo_promedio INT NOT NULL, -- en minutos
			descripcion NVARCHAR(255) NOT NULL
);

CREATE TABLE PedidoEstadoPedido (
			idPedido int NOT NULL,
			idEstadoPedido int NOT NULL,
			fecha_inicio DATE,
			FOREIGN KEY (idPedido) REFERENCES Pedido(id),
			FOREIGN KEY (idEstadoPedido) REFERENCES EstadoPedido(id),
			PRIMARY KEY (idPedido, idEstadoPedido, fecha_inicio)
);
