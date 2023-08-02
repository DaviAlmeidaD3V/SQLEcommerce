create database ecommerce;
use ecommerce;

create table Clients (
	idClient int auto_increment primary key,
    Fname varchar(15),
    Minit char(3),
    Lname varchar(20),
	CPF char(11) not null,
    Address varchar(30),
    constraint unique_cpf_client unique (CPF)
);


create table Product (
	idProduct int auto_increment primary key,
    Pname varchar(15),
    classification_kids bool default false,
    category enum("Electronic", "Clothes", "Food") not null,
    avaliations float,
    size varchar(10)
);

create table Orders (
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum("Confirmed", "Canceled", "In Proccess") default "In Proccess",
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    constraint fk_order_client foreign key (idOrderClient) references Clients (idClient)
		on update cascade
);


create table ProductsStorage (
	idProdStorage int auto_increment primary key,
	storageLocation  varchar(255),
    quantity int default 0
);

create table Supplier (
	idSupplier int auto_increment primary key,
	corporateName  varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_suplier_cpnj unique (CNPJ)
);

create table Seller (
	idSeller int auto_increment primary key,
	AbstName  varchar(255),
	CNPJ char(15) not null,
    CPF char(9),
    location varchar(255),
	contact char(11) not null,
    constraint unique_seller_cnpj unique (CNPJ),
    constraint unique_seller_cpf unique (CPF)
);

create table ProductSeller (
	idPSelller int,
    idProduct int,
    prodQuantity int default 1,
	primary key (idPSelller, idProduct),
    constraint fk_product_seller foreign key (idPSelller) references Seller (idSeller),
    constraint fk_product_product foreign key (idProduct) references Product (idProduct)
);

create table ProductOrder (
	idPOProduct int,
    idPOorder int,
    prodQuantity int default 1,
    poStatus enum("Avaiable", "Not Avaiable") default "Avaiable",
	primary key (idPOProduct, idPOorder),
    constraint fk_product_order_seller foreign key (idPOProduct) references Product (idProduct),
    constraint fk_product_order_product foreign key (idPOorder) references ProductsStorage (idProdStorage)
);

create table StorageLocation (
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
	primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references Product (idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references Orders (idOrder)
);

create table ProductSupplier (
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
	primary key (idPsSupplier, idPsProduct),
	constraint fk_product_supplier_supplier foreign key (idPsSupplier) references Supplier (idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references Product (idProduct)
)
