CREATE DATABASE prueba;
\c prueba
--creando tablas
CREATE TABLE clientes(id_cliente SERIAL PRIMARY KEY, nombre VARCHAR(70) NOT NULL, rut INT, direccion VARCHAR(100) NOT NULL);

CREATE TABLE categorias(id_categoria SERIAL PRIMARY KEY, nombre VARCHAR(70), descripcion VARCHAR(100));

CREATE TABLE productos(id_producto SERIAL PRIMARY KEY, nombre VARCHAR(70), descripcion VARCHAR(100), valor_unitario INT, id_categoria INT, FOREIGN KEY(id_categoria) REFERENCES categorias(id_categoria));

CREATE TABLE facturas(id_factura SERIAL PRIMARY KEY, fecha DATE, id_cliente INT, FOREIGN KEY(id_cliente) REFERENCES clientes(id_cliente), subtotal INT, iva INT, total INT);

CREATE TABLE facturaproducto(id SERIAL, id_cliente INT, FOREIGN KEY(id_cliente) REFERENCES clientes(id_cliente), id_factura INT, FOREIGN KEY(id_factura) REFERENCES facturas(id_factura), id_producto INT, FOREIGN KEY(id_producto) REFERENCES productos(id_producto), cantidad INT);


--insertando datos
INSERT INTO clientes(nombre, rut, direccion) VALUES ('cliente1', 2000000, 'alameda 500'), ('cliente2', 7800000, 'Apoquindo 3000'), ('cliente3', 9000000, 'maipu 5000'), ('cliente4', 15300000, 'carmen 300'), ('cliente5', 98100000, 'vicuña mackena 400');

INSERT INTO categorias(nombre, descripcion) VALUES ('articulos de limpieza', 'productos varios para uso domestico'), ('abarrotes', 'alimentos envasados con valores nutricionales'), ('helados', 'marcas nacionales e internacionales');

INSERT INTO productos(nombre, descripcion, valor_unitario, id_categoria) VALUES ('producto1', 'limpiador de oxido para todo tipo de metales', 150,1), ('producto2', 'helado de vainilla frutos del bosque con aroma a vainilla', 100, 3), ('producto3', 'fideos de colores con salsa incluida', 50, 2), ('producto4', 'atún con producto sin conservantes', 150, 2), ('producto5', 'desodorante aroma a bosque', 70, 2), ('producto6', 'agua con sabores tropicales', 30, 2), ('producto7', 'shampoo para todo tipo de cabellos', 10, 2), ('producto8', 'chocolate con cacao 100%', 5, 2);


--facturas cliente 1
INSERT INTO facturas(fecha, id_cliente) VALUES('2020-06-01', 1);
INSERT INTO facturaproducto(id_cliente, id_factura, id_producto, cantidad) VALUES(1, 1, 1, 1), (1,1,1,2);
UPDATE facturas SET subtotal=(SELECT SUM(valor_unitario*cantidad) FROM facturaproducto, productos WHERE facturaproducto.id_producto = productos.id_producto AND facturaproducto.id_factura=1 GROUP BY id_factura) WHERE id_factura=1;

INSERT INTO facturas(fecha, id_cliente) VALUES('2020-06-02', 1);
INSERT INTO facturaproducto(id_cliente, id_factura, id_producto, cantidad) VALUES(1, 2, 2, 1), (1,2,3,2), (1,2,3,1);
UPDATE facturas SET subtotal=(SELECT SUM(valor_unitario*cantidad)FROM facturaproducto, productos WHERE facturaproducto.id_producto = productos.id_producto AND facturaproducto.id_factura=2 GROUP BY id_factura)WHERE id_factura=2;


--facturas cliente 2
INSERT INTO facturas(fecha, id_cliente) VALUES('2020-06-03', 2);
INSERT INTO facturaproducto(id_cliente, id_factura, id_producto, cantidad) VALUES(2, 3, 4, 1), (2,3,5,2), (2,3,6,1);
UPDATE facturas SET subtotal=(SELECT SUM(valor_unitario*cantidad)FROM facturaproducto, productos WHERE facturaproducto.id_producto = productos.id_producto AND facturaproducto.id_factura=3 GROUP BY id_factura)WHERE id_factura=3;

INSERT INTO facturas(fecha, id_cliente) VALUES('2020-06-10', 2);
INSERT INTO facturaproducto(id_cliente, id_factura, id_producto, cantidad) VALUES(2, 4, 2, 1), (2,4,6,2);
UPDATE facturas SET subtotal=(SELECT SUM(valor_unitario*cantidad)FROM facturaproducto, productos WHERE facturaproducto.id_producto = productos.id_producto AND facturaproducto.id_factura=4 GROUP BY id_factura)WHERE id_factura=4;

INSERT INTO facturas(fecha, id_cliente) VALUES('2020-06-11', 2);
INSERT INTO facturaproducto(id_cliente, id_factura, id_producto, cantidad) VALUES(2, 5, 3, 2), (2,5,1,2), (2,5,8,1);
UPDATE facturas SET subtotal=(SELECT SUM(valor_unitario*cantidad)FROM facturaproducto, productos WHERE facturaproducto.id_producto = productos.id_producto AND facturaproducto.id_factura=5 GROUP BY id_factura)WHERE id_factura=5;


--factura cliente 3
INSERT INTO facturas(fecha, id_cliente) VALUES('2020-06-12', 3);
INSERT INTO facturaproducto(id_cliente, id_factura, id_producto, cantidad) VALUES(3, 6, 3, 1);
UPDATE facturas SET subtotal=(SELECT SUM(valor_unitario*cantidad)FROM facturaproducto, productos WHERE facturaproducto.id_producto = productos.id_producto AND facturaproducto.id_factura=6 GROUP BY id_factura)WHERE id_factura=6;


--factura cliente 4
INSERT INTO facturas(fecha, id_cliente) VALUES('2020-06-15', 4);
INSERT INTO facturaproducto(id_cliente, id_factura, id_producto, cantidad) VALUES(4, 7, 8, 1), (4,7,6,1);
UPDATE facturas SET subtotal=(SELECT SUM(valor_unitario*cantidad)FROM facturaproducto, productos WHERE facturaproducto.id_producto = productos.id_producto AND facturaproducto.id_factura=7 GROUP BY id_factura)WHERE id_factura=7;

INSERT INTO facturas(fecha, id_cliente) VALUES('2020-06-17', 4);
INSERT INTO facturaproducto(id_cliente, id_factura, id_producto, cantidad) VALUES(4, 8, 1, 2), (4,8,3,1),(4,8,1,1);
UPDATE facturas SET subtotal=(SELECT SUM(valor_unitario*cantidad)FROM facturaproducto, productos WHERE facturaproducto.id_producto = productos.id_producto AND facturaproducto.id_factura=8 GROUP BY id_factura)WHERE id_factura=8;

INSERT INTO facturas(fecha, id_cliente) VALUES('2020-06-20', 4);
INSERT INTO facturaproducto(id_cliente, id_factura, id_producto, cantidad) VALUES(4, 9, 2, 2), (4,9,3,1), (4,9,3,1), (4,9,8,1);
UPDATE facturas SET subtotal=(SELECT SUM(valor_unitario*cantidad)FROM facturaproducto, productos WHERE facturaproducto.id_producto = productos.id_producto AND facturaproducto.id_factura=9 GROUP BY id_factura)WHERE id_factura=9;

INSERT INTO facturas(fecha, id_cliente) VALUES('2020-06-22', 4);
INSERT INTO facturaproducto(id_cliente, id_factura, id_producto, cantidad) VALUES(4, 10, 1, 2);
UPDATE facturas SET subtotal=(SELECT SUM(valor_unitario*cantidad)FROM facturaproducto, productos WHERE facturaproducto.id_producto = productos.id_producto AND facturaproducto.id_factura=10 GROUP BY id_factura)WHERE id_factura=10;

--iva
UPDATE facturas SET iva= subtotal*0.19;
UPDATE facturas SET total= subtotal+iva;
SELECT id_factura, cantidad, valor_unitario FROM productos, facturaproducto WHERE facturaproducto.id_producto = productos.id_producto;
--parte 3

--cliente con la compra más alta
SELECT clientes.nombre,  max(total) FROM clientes, facturas WHERE clientes.id_cliente = facturas.id_cliente GROUP BY clientes.nombre ORDER BY max DESC LIMIT 1;


-- cliente que pagó sobre 100 de monto
SELECT clientes.nombre FROM clientes, facturas WHERE clientes.id_cliente = facturas.id_cliente AND facturas.total > 100 GROUP BY nombre HAVING count(nombre)>1;


-- cuantos clientes han comprado el producto 6
SELECT count(clientes.nombre) FROM clientes, facturaproducto WHERE clientes.id_cliente = facturaproducto.id_cliente AND facturaproducto.id_producto=6 GROUP BY nombre HAVING count(nombre)>1;

--opcional
SELECT clientes.nombre FROM clientes, facturaproducto WHERE clientes.id_cliente = facturaproducto.id_cliente AND facturaproducto.id_producto=6 GROUP BY nombre having count(nombre)>0;