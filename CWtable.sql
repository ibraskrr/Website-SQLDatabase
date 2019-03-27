INSERT INTO Staff (StaffID, Name) VALUES (1, 'Robert Bibb');

INSERT INTO Staff (StaffID, Name) VALUES (2, 'Eleanor Mendoza');



INSERT INTO Product (ProductID, Name) VALUES (1, 'MyBackup');

INSERT INTO Product (ProductID, Name) VALUES (2, 'MyOrganiser');

INSERT INTO Product (ProductID, Name) VALUES (3, 'MyMediaStore');




INSERT INTO Customer (CustomerID, Name,email) VALUES (1, 'Louie Allen', 'louallen@yazoo.net');

INSERT INTO Customer (CustomerID, Name,email) VALUES (2, 'Stephanie bares', 'stephbares@yazoo.net');

INSERT INTO Customer (CustomerID, Name,email) VALUES (3, 'Sam Porter', 'samporter@yazoo.net');

INSERT INTO Customer (CustomerID, Name,email) VALUES (4, 'Kashish Patel', 'kash@yazoo.net');



INSERT INTO Ticket (TicketID, Problem, Status, Priority, LoggedTime, CustomerID, ProductID) VALUES

	(1000, 'Can I degrade my windows 10 to windows 9', 'open', 3, '2018-04-20 19:21', 2, 1);

INSERT INTO TicketUpdate (TicketUpdateID, Message, UpdateTime, StaffID, TicketID) VALUES 

	(10000, 'It goes against windows bylaws to degrade your windows setting on purpose','2018-04-21 20:27', 1, 1000);

UPDATE Ticket SET status = 'closed' WHERE TicketID = 1000;



INSERT INTO Ticket (TicketID, Problem, Status, Priority, LoggedTime, CustomerID, ProductID) VALUES

	(1001, 'Can I set up a pattern lock on my phone?', 'open', 3, '2018-04-18 17:06', 2, 2);

INSERT INTO TicketUpdate (TicketUpdateID, Message, UpdateTime, TicketID, StaffID) VALUES 

	(10001, 'Go onto setting/security/password/patternsandpin and select what pattern you would like',

	'2018-04-18 17:47', 1001, 1);

INSERT INTO TicketUpdate (TicketUpdateID, Message, UpdateTime, TicketID, StaffID) VALUES 

	(10002, 'Thank you, can I also set up a fingerprint lock without a biometric scanner on my phone?',

	'2018-04-19 09:08', 1001, NULL);

INSERT INTO TicketUpdate (TicketUpdateID, Message, UpdateTime, TicketID, StaffID) VALUES 

	(10003, 'unfortunately you cannot without the fingerprint scanner being an available feature on your phone',

	'2018-04-19 10:21', 1001, 1);

UPDATE Ticket SET status = 'closed' WHERE TicketID = 1001;



INSERT INTO Ticket (TicketID, Problem, Status, Priority, LoggedTime, CustomerID, ProductID) VALUES

	(1002, 'I accidently deleted an email from my mailbox is there anyway i can retreve it?', 'open', 1, '2018-04-18 10:01', 3, 1);

INSERT INTO TicketUpdate (TicketUpdateID, Message, UpdateTime, TicketID, StaffID) VALUES 

	(10004, 'There typically is a deleted items  label within your chosen emailing platform','2018-04-19 09:08', 1002, 2);

INSERT INTO TicketUpdate (TicketUpdateID, Message, UpdateTime, TicketID, StaffID) VALUES 

	(10005, 'That worked fine. Thank you!', '2018-04-19 09:38', 1002, NULL);

UPDATE Ticket SET status = 'closed' WHERE TicketID = 1002;



INSERT INTO Ticket (TicketID, Problem, Status, Priority, LoggedTime, CustomerID, ProductID) VALUES

	(1003, 'How can I set a birthday on my google calender', 'open', 2, '2018-04-19 09:48', 4, 2);

INSERT INTO TicketUpdate (TicketUpdateID, Message, UpdateTime, TicketID, StaffID) VALUES 

	(10006, 'Go onto the google calender website and select your date and year and it will remember for ever!',	'2018-04-19 11:51', 1003, 2);

INSERT INTO TicketUpdate (TicketUpdateID, Message, UpdateTime, TicketID, StaffID) VALUES 

	(10007, 'Thank you, I guess this should mean I never forget a birthday','2018-04-19 12:03', 1003, NULL);



INSERT INTO Ticket (TicketID, Problem, Status, Priority, LoggedTime, CustomerID, ProductID) VALUES

	(1004, 'How do I add a new cover photo on facebook', 'open', 2, '2018-04-19 11:10', 1, 1);

INSERT INTO Ticket (TicketID, Problem, Status, Priority, LoggedTime, CustomerID, ProductID) VALUES

	(1005, 'On your profile go on to the bottom right of your cover and you should be able to upload a new picture ', 'open', 2, '2018-04-10 14:10', 3, 3);

INSERT INTO TicketUpdate (TicketUpdateID, Message, UpdateTime, TicketID, StaffID) VALUES 

	(10008, 'Thank you',

	'2018-04-10 15:03', 1005, 2);



--  TO CHECK DATA ENTERED CORRECTLY


Select count(*) from staff; -- returns 2
select count(*) from product; --returns 3
Select count(*) from customer;-- returns 4
Select count(*) from ticket; -- returns 6
select count(*)from ticket; -- returns 6
