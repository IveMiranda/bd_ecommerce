-- Criação do BD ecommerce

CREATE DATABASE ecommerce;

USE ecommerce; 

-- Criar Tabela cliente
CREATE TABLE cliente(
	Id_client INT AUTO_INCREMENT PRIMARY KEY,
    Fname varchar(15) NOT NULL,
    Minit char,
    Lname varchar(15) NOT NULL,
    CPF char(11) NOT NULL,
    Bdate DATE,
    Address varchar(30),
    Sex enum('M', 'F', 'Outro'),
    Marital_status enum('Single', 'Married', 'Other'),
    CONSTRAINT unique_cpf_client UNIQUE (CPF)
);

-- Criar Tabela produto
CREATE TABLE product(
	id_Product INT AUTO_INCREMENT PRIMARY KEY,
    Pname varchar(15) NOT NULL,
    Category enum('Children', 'Adult', 'Home', 'Other'),
    Section enum('Electronics', 'Home decor', 'Furniture', 'Toys', 'Clothing', 'Accessories') NOT NULL,
    Descriptions varchar(50) NOT NULL default 'No description',
    Assessment float default 0,
    Size varchar(10),
    supplier varchar(20),
    CONSTRAINT unique_id_Product UNIQUE (id_Product)
);

-- Criar Tabela forma de pagamento
CREATE TABLE clientFormPayment (
  id_clientFormPayment INT AUTO_INCREMENT PRIMARY KEY,
  id_client integer NOT NULL,
  FormPayment enum('Credit card', 'Bank slip', 'PIX', 'Other'),
  NumCard VARCHAR(45),
  ValidityCard DATE,
  NameCard VARCHAR(45),
  CONSTRAINT fk_ClientFormPayment_Client
    FOREIGN KEY (id_client)
    REFERENCES cliente (id_client)
);
 
ALTER TABLE clientFormPayment DROP ValidityCard;
ALTER TABLE clientFormPayment ADD ValidityCard VARCHAR(45) default 0; 

-- Criar Tabela pedido
CREATE TABLE pedido (
  id_pedido INT AUTO_INCREMENT PRIMARY KEY,
  DatePedido TIMESTAMP NOT NULL DEFAULT now(),
  ListProduct VARCHAR(45) NOT NULL,
  id_client integer NOT NULL,
  id_clientFormPayment integer NOT NULL,
  DeliveryAddress varchar(30) NOT NULL,
  CodigoRastreio VARCHAR(45) NOT NULL,
  CONSTRAINT fk_Pedido_Cliente
    FOREIGN KEY (id_client)
    REFERENCES Cliente (id_client),
  CONSTRAINT fk_Pedido_ClientFormPayment
    FOREIGN KEY (id_clientFormPayment)
    REFERENCES clientFormPayment (id_clientFormPayment)
);
DESC pedido;
ALTER TABLE pedido DROP CodigoRastreio;
ALTER TABLE pedido ADD TrackingCode VARCHAR(45) NOT NULL;
ALTER TABLE pedido ADD ValueOrder float default 0;
ALTER TABLE pedido DROP ListProduct;
ALTER TABLE pedido ADD id_Product int;
ALTER TABLE pedido ADD CONSTRAINT fk_Id_Product_Pedido
    FOREIGN KEY (id_Product)
    REFERENCES product (id_Product);
  
-- Criar Tabela fornecedor 
CREATE TABLE supplier (
  id_supplier INT AUTO_INCREMENT PRIMARY KEY,
  Cnpj VARCHAR(20) NOT NULL,
  NameCompany VARCHAR(45) NOT NULL,
  PostalCode VARCHAR(10) NOT NULL,
  AddressCompany VARCHAR(45) NOT NULL,
  Phone VARCHAR(12) NOT NULL,
  Email VARCHAR(45) NOT NULL
);

-- Criar Tabela fornecedor_produto
CREATE TABLE supplierProduct (
  id_supplier integer NOT NULL,
  id_Product integer NOT NULL,
  PRIMARY KEY (id_supplier, id_Product),
  CONSTRAINT fk_supplierProduct_supplier
    FOREIGN KEY (  id_supplier)
    REFERENCES supplier (  id_supplier),
  CONSTRAINT fk_supplierProduct_Product
    FOREIGN KEY (id_Product)
    REFERENCES product (id_Product)
);	

-- Criar Tabela estoque
CREATE TABLE stock (
  id_stock INT AUTO_INCREMENT PRIMARY KEY,
  location VARCHAR(45) NOT NULL
  );

-- Criar Tabela produto_estoque
CREATE TABLE product_stock (
  id_Product integer NOT NULL,
  id_stock integer NOT NULL,
  Quantidade FLOAT NOT NULL,
  PRIMARY KEY (id_Product, id_stock),
  CONSTRAINT fk_ProductStock_Product
    FOREIGN KEY (id_Product)
    REFERENCES product (id_Product),
  CONSTRAINT fk_ProductStock_stock
    FOREIGN KEY (id_stock)
    REFERENCES stock (id_stock)
);

-- Criar Tabela status_pedido
CREATE TABLE StatusPedido (
  id_status enum('Waiting for payment confirmation', 'Preparing order', 'Order dispatched', 'Order delivered', 'returned order') NOT NULL,
  id_pedido integer,
  DatePedido timestamp DEFAULT now(),
  PRIMARY KEY (id_status, id_pedido, DatePedido),
  CONSTRAINT fk_StatusPedido_Pedido
    FOREIGN KEY (id_pedido)
    REFERENCES pedido (id_pedido)
);

-- Inserir dados na tabela cliente
DESC cliente; 
INSERT INTO cliente VALUES	(1, 'Ive', 'A', 'Miranda', 12345678912, '1979-05-10', 'Rua Amarela, 50, Bruaque/SC', 'F', 'Married'),
							(2, 'Joel', 'A', 'Pinto', 13245768934, '1982-08-05', 'Rua Amarela, 50, Bruaque/SC', 'M', 'Married'),
                            (3, 'Bianca', 'A', 'Miranda', 23146758956, '2003-03-26', 'Rua Amarela, 50, Bruaque/SC', 'F', 'Single'),
                            (4, 'Beatriz', 'A', 'Miranda', 31247568978, '2006-05-25', 'Rua Amarela, 50, Bruaque/SC', 'F', 'Single'),
                            (5, 'Grijas', 'M', 'Linhares', 42345978990, '1979-05-10', 'Rua Amarela, 50, Bruaque/SC', 'M', 'Married'),
                            (6, 'Eliany', 'A', 'Miranda', 52741673913, '1979-05-10', 'Rua Amarela, 50, Bruaque/SC', 'F', 'Married'),
                            (7, 'Sergio', 'A', 'Renhe', 43246768024, '1992-02-15', 'Rua Marrom, 48, Fortaleza/CE', 'M', 'Single'),
                            (8, 'Natércia', 'A', 'Freitas', 13245757857, '1973-10-06', 'Rua Rosa, 59, Fortaleza/CE', 'F','Other'),
                            (9, 'Felipe', 'A', 'Freitas', 91845538935, '2002-02-13', 'Rua Verde, 100, Fortaleza/CE', 'M', 'Other'),
                            (10, 'Jully', 'N', 'Amarok', 68395958246, '2000-11-11', 'Rua Amarela, 50, Bruaque/SC', 'F', 'Other'),
                            (11, 'Hannah', 'A', 'Miranda', 72842675997, '2001-10-07', 'Rua Amarela, 50, Bruaque/SC', 'F', 'Single'),
                            (12, 'Eliaine', 'S', 'Paula', 22445878013, '1957-01-23', 'Rua Flores, 37, Fortaleza/CE', 'F', 'Married'),
							(13, 'Pedro', 'A', 'Nogueira', 43545068237, '1947-08-24', 'Rua Flores, 37, Fortaleza/CE', 'M', 'Married'),
                            (14, 'Cila', 'M', 'Rolim', 13136748946, '1950-03-26', 'Rua Jardins, 100, Luiziânia/GO', 'F', 'Married'),
                            (15, 'Cláudia', 'M', 'Vargas', 41237528968, '1960-04-21', 'Rua Amanhecer, 52, Brasília/DF', 'F', 'Married'),
                            (16, 'Evilânio', 'L', 'Pessoa', 62545976972, '1975-10-20', 'Rua Acásia, 120, Fortaleza/CE', 'M', 'Other'),
                            (17, 'Elaine', 'A', 'Silva', 92751683015, '1959-06-17','Rua Acásia, 120, Fortaleza/CE', 'F', 'Other'),
                            (18, 'Jaelan', 'A', 'Silva', 83256778129, '1952-08-23', 'Rua Palmeiras, 1, Fortaleza/CE', 'M', 'Other'),
                            (19, 'Paula', 'L', 'Borges', 93255756856, '1993-12-16', 'Rua Roxa, 159, Fortaleza/CE', 'F','Other'),
                            (20, 'Guilherme', 'S', 'Leite', 51445138531, '2002-02-13', 'Rua Azul, 100, Fortaleza/CE', 'M', 'Single'),
                            (21, 'Edilane', 'S', 'Leite', 98398958549, '1951-12-23', 'Rua Estrela, 50, Fortaleza/CE', 'F','Other'),
                            (22, 'Camilla', 'F', 'Jucá', 52640655795, '1979-06-27', 'Rua Branca, 350, Natal/RN', 'F', 'Married');
 
 SELECT * FROM cliente;
 
 -- Inserir dados na tabela produto
DESC product; 
INSERT INTO product VALUES 	(100, 'Televisão', 'Home', 'Electronics', 'Aparelho de TV', 5.0, 'Peq', 'LG'),
							(101, 'Geladeira', 'Home', 'Electronics', 'Geladeira', 4.9, 'Gran', 'Brastemp'),
                            (102, 'Microondas', 'Home', 'Electronics', 'Microondas', 3.5, 'Peq', 'Cônsul'),
                            (103, 'Fogão', 'Home', 'Electronics', 'Fogão', 4.3, 'Med', 'Esmaltec'),
							(104, 'Fritadeira', 'Home', 'Electronics', 'Fritadeira', 5.0, 'Peq', 'Oster'),
                            (105, 'Liquidificador', 'Home', 'Electronics', 'Liquidificador', 4.5, 'Peq', 'Oster'),
                            (200, 'Tapete', 'Home', 'Home decor', 'Tapete', 4.3, 'Med', 'Casa bonita'),
                            (201, 'Manta', 'Home', 'Home decor', 'Manta', 3.9, 'Med', 'Casa bonita'),
                            (202, 'Almofada', 'Home', 'Home decor', 'Almofada', 4.9, 'Peq', 'Casa bonita'),
                            (203, 'Tela','Home', 'Home decor',  'Tela', 5.0, 'Peq', 'Mais cor'),
                            (204, 'Jarro', 'Home', 'Home decor',  'Jarro', 4.7, 'Peq', 'Mais cor'),
                            (205, 'Espenho', 'Home', 'Home decor',  'Espenho', 5.0, 'Peq', 'Linda casa'),
                            (301, 'Sofá', 'Home', 'Furniture', 'Sofá', 4.9, 'Gran', 'Top Móveis'),
                            (302, 'Mesa', 'Home',  'Furniture','Mesa', 3.5, 'Peq', 'Top Móveis'),
                            (303, 'Armário', 'Home',  'Furniture','Armário', 4.3, 'Med', 'Mais Móveis'),
							(304, 'Guarda-roupa', 'Home', 'Furniture','Guarda-roupa', 5.0, 'Gran', 'Mais Móveis'),
                            (305, 'Bancada', 'Home', 'Furniture', 'Bancada', 4.5, 'Gran', 'Mais Móveis'),
                            (400, 'Boneca', 'Children', 'Toys', 'Boneca', 4.3, 'Med', 'Toy Stock'),
                            (401, 'Casa', 'Children', 'Toys', 'Casa', 3.9, 'Med', 'Toy Stock'),
                            (402, 'Jogo', 'Children', 'Toys', 'Jogo', 4.9, 'Peq', 'Grow'),
                            (403, 'Piscina', 'Children', 'Toys', 'Tela', 5.0, 'Gran', 'Mais Kids'),
                            (404, 'Carro', 'Children', 'Toys', 'Carro', 4.7, 'Peq', 'Mais Kids'),
                            (405, 'Varretas', 'Children', 'Toys', 'Varretas', 5.0, 'Peq', 'Mais Kids'),
                            (500, 'Blusa', 'Children', 'Clothing', 'Blusa', 4.3, 'Med', 'Vest Kids'),
                            (501, 'Short', 'Children', 'Clothing', 'Short', 3.9, 'Med', 'Vest Kids'),
                            (502, 'Calça', 'Children', 'Clothing', 'Calça', 4.9, 'Peq', 'Vest Kids'),
                            (503, 'Blusa', 'Adult', 'Clothing', 'Blusa', 4.3, 'Med', 'Stilo'),
                            (504, 'Short', 'Adult', 'Clothing', 'Short', 3.9, 'Med', 'Stilo'),
                            (505, 'Calça', 'Adult', 'Clothing', 'Calça', 4.9, 'Peq', 'Stilo'),
                            (600, 'Tiara', 'Adult', 'Accessories', 'Tiara', 3.9, 'Peq', 'BemBela'),
                            (601, 'Óculos', 'Children', 'Accessories', 'Tiara', 4.9, 'Pwq', 'BemBela'),
                            (602, 'Lenço', 'Adult', 'Accessories', 'Lenço', 4.9, 'Peq', 'BemBela');
                            
SELECT * FROM product;
 
-- Inserir dados na tabela produto
DESC clientFormPayment; 
INSERT INTO clientFormPayment VALUES (100, 1, 'Credit card', 54345678904, '2024-10-15', 'Mastercard'),
									 (101, 2, 'Bank slip', 'null', 'null', 'null'),
									 (102, 3, 'PIX', 'null', 'null', 'null'),
									 (103, 4, 'Credit card', 54345978990, '2027-12-05', 'Mastercard'),
									 (104, 5, 'PIX', 'null', 'null', 'null'),
									 (105, 6, 'PIX', 'null', 'null', 'null'),
									 (106, 7, 'PIX', 'null', 'null', 'null'),
									 (107, 8, 'PIX', 'null', 'null', 'null'),
                                     (108, 9, 'Credit card', 78845538997, '2024-10-15', 'AmericaExpress'),
									 (109, 10, 'PIX', 'null', 'null', 'null'),
									 (110, 11, 'PIX', 'null', 'null', 'null'),
									 (111, 12, 'PIX', 'null', 'null', 'null'),
									 (112, 13, 'PIX', 'null', 'null', 'null'),
									 (113, 14, 'Bank slip', 'null', 'null', 'null'),
									 (114, 15, 'Bank slip', 'null', 'null', 'null'),
									 (115, 16, 'PIX', 'null', 'null', 'null'),
									 (116, 17, 'PIX', 'null', 'null', 'null'),
									 (117, 18, 'Bank slip', 'null', 'null', 'null'),
									 (118, 19, 'PIX', 'null', 'null', 'null'),
									 (119, 20, 'PIX', 'null', 'null', 'null'),
									 (120, 21, 'Credit card', 83256778115, '2025-12-23', 'Dinners'),
									 (121, 22, 'PIX', 'null', 'null', 'null');

SELECT * FROM clientFormPayment; 

-- Inserir dados na tabela pedido
DESC pedido; 
INSERT INTO pedido VALUES (1, '2023-02-12', 1, 100, 'Rua Amarela, 50, Bruaque/SC', '88700502', 2500.00, 100),
						  (2, '2023-02-15', 2, 101, 'Rua Amarela, 50, Bruaque/SC', '88700502', 600.00, 101),
                          (3, '2023-02-20', 3, 102, 'Rua Amarela, 50, Bruaque/SC', '88700502', 720.00, 102),
						  (4, '2023-02-28', 4, 103, 'Rua Amarela, 50, Bruaque/SC', '88700502', 547.80, 103),
                          (5, '2023-03-02', 5, 104, 'Rua Amarela, 50, Bruaque/SC', '88700502', 481.99, 104),
						  (6, '2023-03-17', 6, 105, 'Rua Amarela, 50, Bruaque/SC', '88700502', 2500.00, 105),
                          (7, '2023-03-22', 7, 106, 'Rua Marrom, 48, Fortaleza/CE', '607115487', 600.00, 101),
						  (8, '2023-03-25', 8, 107, 'Rua Rosa, 59, Fortaleza/CE', '60240812', 2500.00, 100),
                          (9, '2023-03-28', 9, 108, 'Rua Verde, 100, Fortaleza/CE', '60258852', 720.00, 102),
						  (10, '2023-04-03', 10, 109, 'Rua Amarela, 50, Bruaque/SC', '88700502', 547.80, 103),
                          (11, '2023-04-10', 11, 110, 'Rua Amarela, 50, Bruaque/SC', '88700502', 2500.00, 100),
						  (12, '2023-05-13', 12, 111, 'Rua Flores, 37, Fortaleza/CE', '60147852', 600.00, 101),
                          (13, '2023-05-16', 13, 112, 'Rua Flores, 37, Fortaleza/CE', '60147852', 2500.00, 100),
						  (14, '2023-05-23', 14, 113, 'Rua Jardins, 100, Luiziânia/GO', '45987654', 481.99, 104),
                          (15, '2023-06-01', 15, 114, 'Rua Amanhecer, 52, Brasília/DF', '48159357', 600.00, 101),
						  (16, '2023-06-05', 16, 115, 'Rua Acásia, 120, Fortaleza/CE', '60824000', 2500.00, 100),
                          (17, '2023-06-14', 17, 116, 'Rua Acásia, 120, Fortaleza/CE', '60824000', 2500.00, 100),
                          (18, '2023-07-03', 18, 117, 'Rua Palmeiras, 1, Fortaleza/CE', '60376179', 600.00, 101),
                          (19, '2023-07-09', 19, 118, 'Rua Roxa, 159, Fortaleza/CE', '60963852', 481.99, 104),
                          (20, '2023-07-12', 20, 119, 'Rua Azul, 100, Fortaleza/CE', '60854796', 2500.00, 100),
                          (21, '2023-07-24', 21, 120, 'Rua Estrela, 50, Fortaleza/CE', '60700547', 481.99, 104),
                          (22, '2023-08-02', 22, 121, 'Rua Branca, 350, Natal/RN', '71943971', 600.00, 101);

SELECT * FROM pedido;

-- Inserir dados na tabela produto
DESC StatusPedido; 
INSERT INTO StatusPedido VALUES	('Order dispatched', 1, '2023-02-12'),
								('Order dispatched', 2, '2023-02-15'),
								('Order dispatched', 3, '2023-02-20'),
								('Order dispatched', 4, '2023-02-28'),
								('Order dispatched', 5, '2023-03-02'),
								('Order dispatched', 6, '2023-03-17'),
								('Order dispatched', 7, '2023-03-22'),
								('Order dispatched', 8, '2023-03-25'),
								('Order dispatched', 9, '2023-03-28'),
								('Order dispatched', 10, '2023-04-03'),
								('Order dispatched', 11, '2023-04-10'),
								('Order dispatched', 12, '2023-05-13'),
								('Order dispatched', 13, '2023-05-16'),
								('Order dispatched', 14, '2023-05-23'),
								('Returned order', 15, '2023-06-01'),
								('Order dispatched', 16, '2023-06-05'),
								('Order dispatched', 17, '2023-06-14'),
								('Order dispatched', 18, '2023-07-03'),
								('Order dispatched', 19, '2023-07-09'),
								('Order dispatched', 20, '2023-07-12'),
								('Order dispatched', 21, '2023-07-24'),
								('Preparing order', 22, '2023-08-02');	
                                
SELECT * FROM StatusPedido;

-- Análise
-- Tivemos algum problema de devolução de pedido em 2023? Caso positivo, disponibilizar cupom de desconto para o cliente insatisfeito.
SELECT c.id_client, CONCAT(Fname, ' ', Lname) AS Client_Name, p.DatePedido, ValueOrder, id_status  FROM cliente c JOIN pedido p JOIN StatusPedido s ON c.id_client = p.id_client AND p.id_pedido = s.id_pedido WHERE id_status =  'Returned order';

