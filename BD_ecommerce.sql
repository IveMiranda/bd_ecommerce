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

-- Criar Tabela form of payment
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
 