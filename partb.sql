-- Question 1

-- Problem 1 encountered 
insert into customer(customerId, name, email) VALUES(null, null, NULL);
insert into customer(customerId, name, email) VALUES(32, 'a', 'b');

-- Problem 2 encountered 
insert into customer(customerId, name, email) VALUES(null, null, NULL);
insert into customer(customerId, name, email) VALUES(abcde, 'a', 'b');


-- Solution for problem one and two are the same
insert into customer(customerId, name, email) VALUES(12345, 'a', 'b');
select * from customer where customerId = 12345;


--Question 2 

-- Problem 
insert into Ticket(ticketId, problem, status, priority, loggedtime, customerId, productId)
   VALUES(null, null, null, null, null, null, null);

insert into Ticket(ticketId, problem, status, priority, loggedtime, customerId, productId)
   VALUES(5555555, 'error etc', 'finished', 5, now(), 1, 1);

-- Solution 
insert into Ticket(ticketId, problem, status, priority, loggedtime, customerId, productId)
   VALUES(5555555, 'error status', 'open', 1, now(), 1, 1);

   
select *from ticket where ticketId = 600000;

--Question 3

-- Problems
insert into ticketupdate(ticketupdateId, message, updatetime, ticketId, staffId)
   VALUES(null, null, null, null, null);
   
insert into ticketupdate(ticketupdateId, message, updatetime, ticketId, staffId)
   VALUES(5555555, 'ticket not available', now(), 0, null);

insert into ticketupdate(ticketupdateId, message, updatetime, ticketId, staffId)
   VALUES(5555555, 'ticket not available', now(), -1, -3);

insert into ticketupdate(ticketupdateId, message, updatetime, ticketId, staffId)
   VALUES(622, 'ticket id not available', now(), 1, 1);

--Solutions
insert into ticketupdate(ticketupdateId, message, updatetime, ticketId, staffId)
   VALUES(10001, 'not available', now(), 1000, 1);

select * from ticketupdate where ticketupdateid = 10001;
select * from ticket where ticketid = 1000;


--Question 4
select ticket.ticketId, lastupdate from ticket 
  left join (select ticketId, max(updatetime) as lastupdate from ticketupdate group by ticketid) A
  on ticket.ticketId = a.ticketId
  where status = 'open';

--Question 5
update ticket SET status='CLOSED' where ticketId = 5


--Question 6
select ticket.problem, case when u.staffId is null THEN
       (select name from customer where customerId = ticket.customerId)
    else
       (select name from staff where staffId = u.staffId)
    end
    as name, u.updatetime 
    
    from ticket ticket LEFT join ticketupdate u on ticket.ticketId = u.ticketid
    
where ticket.ticketId = 1000 order by updatetime;

--Question 7

select ticketId, loggedtime, first  - loggedTime, last - loggedTime  from 
  (select t.ticketId, t.loggedtime, 
    (select min(updatetime) from ticketupdate where ticketId = t.ticketid ) as first,
    (select max(updatetime) from ticketupdate where ticketId = t.ticketid ) as last
    from ticket t inner join ticketupdate u on t.ticketId = u.ticketId
    where t.status = 'closed'  group by t.ticketId) as A order by ticketId;


--Question 8
--Problem 
delete from customer where customerId = 4;
-- Solution
delete from ticketupdate where ticketId in (select ticketid from ticket where customerId = 4);
delete from ticket where customerid = 4;
delete from customer where customerId = 4;

-- Run these to clear up

delete from ticketupdate;
delete from ticket;

--execute this line to find out how many people have updates
select ticket.ticketid, count(*) from ticketupdate inner join ticket t
    on ticketupdate.ticketid = ticket.ticketid 
	where status = 'closed'
    group by ticket.ticketId ;


