CREATE TABLE Staff
(
	 StaffID	INTEGER primary KEY
	,Name		VARCHAR(40) not null
);
CREATE INDEX staff_name_idx ON public.staff(Name);


CREATE TABLE Product
(
	 ProductID		INTEGER primary KEY
	,Name			VARCHAR(40) not null
);
CREATE INDEX product_name_idx ON public.Product(Name);


CREATE TABLE Customer
(
	 CustomerID		INTEGER primary key
	,Name			VARCHAR(40) not null
	,Email			VARCHAR(40) not null
);
CREATE INDEX customer_name_idx ON public.customer (Name);


CREATE TABLE Ticket
(
	 TicketID		INTEGER primary KEY
	,Problem		VARCHAR(1000) not NULL
	,Status		VARCHAR(20) not NULL
	,Priority		INTEGER not null
	,LoggedTime		TIMESTAMP not null
	,CustomerID		INTEGER references Customer(CustomerID)
	,ProductID		INTEGER references Product(ProductID)
	,check (status = 'open' or status = 'closed')
	-- 1 is highest priority
	,check (priority = 1 or priority = 2 or priority =3)
);


CREATE TABLE TicketUpdate
(
	TicketUpdateID	INTEGER not null primary key
	,Message		VARCHAR(1000) not NULL
	,UpdateTime		TIMESTAMP not NULL
	,TicketID		INTEGER references Ticket(TicketID)
	,StaffID		INTEGER null references Staff(StaffID)
);
