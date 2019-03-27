
-- In postgresql we do not generally use upper case characters
-- for table or column names but
-- "Note that you should NOT modify the name and type of the attributes 
-- (i.e. the information you have been given). Save all your Data Definition
-- Language (DDL) statements in a text file


-- None of the tables have auto generated ID. because
-- "It is not necessary or recommended to auto-generate ID numbers for the tables.
-- IDs will be supplied when data is provided for testing and assessment."
-- This is absolute nonsense and utter rubbish. Quite contrary to the accepted 
-- norms of application design.
-- 
-- The id *should always be generated in the server*. The id should almost never be generated
-- on the client side. Doing so leads to race conditions. To avoid those race conditions
-- application developers need to write extra code. Code that already exists by default
-- in the server implementation and has been tested thoroughly over the years.
--


drop table if exists Staff;
CREATE TABLE Staff
(
	StaffID		INTEGER primary KEY,
	Name		VARCHAR(40) not null
);

drop table if exists Product;
CREATE TABLE Product
(
	ProductID		INTEGER primary KEY,
	Name			VARCHAR(40) not null
);


drop table if exists Customer;
CREATE TABLE Customer
(
	CustomerID		INTEGER primary key,
	Name			VARCHAR(40) not null,
	Email			VARCHAR(40) not null
);

drop table if exists Ticket;
CREATE TABLE Ticket
(
	TicketID		INTEGER primary KEY,
	Problem		VARCHAR(1000) not NULL,
	Status		VARCHAR(20) not NULL,
	Priority		INTEGER not null,
	LoggedTime		TIMESTAMP not null,
	CustomerID		INTEGER references Customer(CustomerID),
	ProductID		INTEGER references Product(ProductID),
	check (status = 'OPEN' or status = 'CLOSED'),
	check (priority = 1 or priority = 2 or priority =3)
);

drop table if exists TicketUpdate;
CREATE TABLE TicketUpdate
(
	TicketUpdateID	INTEGER not null primary key,
	Message		VARCHAR(1000) not NULL,
	UpdateTime		TIMESTAMP not NULL,
	TicketID		INTEGER references Ticket(TicketID),
	StaffID	INTEGER null references Staff(StaffID)
);

-- create indexes
CREATE INDEX staff_name_idx ON public.staff(Name);
-- Since the number of entries in a product table is small it does not
-- need an index. But the professor may need one. Typically tables with
-- only a few hundred entries do not need an index.
CREATE INDEX product_name_idx ON public.Product(Name);
CREATE INDEX customer_name_idx ON public.customer (Name);
