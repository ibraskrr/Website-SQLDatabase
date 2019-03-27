import psycopg2
from flask import Flask, render_template, flash, request

# App config.
DEBUG = True
app = Flask(__name__)
app.config.from_object(__name__)

conn = psycopg2.connect(host="localhost", user="postgres", password='1', dbname='postgres')


@app.route("/", methods=["GET"])
def home():
	'''
	This is how I linked all of the pages up from one file 
	'''

	return render_template("home.html")


@app.route("/customer-add/", methods=["GET", "POST"])
def customer_add():
	'''
	This is how you insert new customers into the database 
	'''
	message = ""

	if request.method == 'POST':
		conn.rollback()
		try:
			cursor = conn.cursor()
			query = "insert into customer(customerId, name, email) VALUES(%s, %s, %s)";			
			cursor.execute(query, [request.form.get('id'), request.form.get('name'), request.form.get('email')])
			conn.commit()
			message = 'Success'

		except (psycopg2.IntegrityError, psycopg2.DataError) as e:
			# insert has failed because of an integrity error or because the required fields
			# have not been filled in.
			conn.rollback()
			print(str(e))
			message = str(e)

	return render_template("customer-form.html", message=message)


@app.route("/ticket-add/", methods=["GET", "POST"])
def ticket_add():
	'''
	Adds a new customer ticket into the database
	'''
	message = ""

	if request.method == 'POST':
		conn.rollback()
		try:
			cursor = conn.cursor()
			query = ("insert into Ticket(ticketId, problem, status, priority, loggedtime, customerId, productId) "
					 "VALUES(%s, %s, %s, %s, now(), %s, %s)");			
			cursor.execute(query, [request.form.get('ticketId'), request.form.get('problem'),
								   request.form.get('status'),
								   request.form.get('customerId'), request.form.get('productId'),
								   request.form.get('priority')
								   ])
			conn.commit()
			message = 'Success'

		except (psycopg2.IntegrityError, psycopg2.DataError) as e:
			conn.rollback()
			print(str(e))
			message = str(e)

	return render_template("ticket-form.html", message=message)


@app.route("/ticket-update-add/", methods=["GET", "POST"])
def ticket_update_add():
	'''
	Adds a new ticket update to the database
	'''
	message = ""

	if request.method == 'POST':
		conn.rollback()
		try:
			cursor = conn.cursor()
			query = ("insert into ticketupdate(ticketupdateId, message, updatetime, ticketId, staffId) "
					 "VALUES(%s, %s, now(), %s, %s)");
			cursor.execute(query, [request.form.get('ticketUpdateId'), request.form.get('message'),
								   request.form.get('ticketId'),
								   request.form.get('staffId')
								   ])
			conn.commit()
			message = 'Success'

		except (psycopg2.IntegrityError, psycopg2.DataError) as e:
			conn.rollback()
			print(str(e))
			message = str(e)

	return render_template("ticket-update-form.html", message=message)


@app.route("/show-open-tickets/", methods=["GET"])
def show_open_tickets():
	'''
	This is where you can see all the open tickets which havent been resolved yet
	'''
	message = ""
	query = ("select * from ticket")
	cursor = conn.cursor()
	cursor.execute(query)

	return render_template("show-results.html", results=cursor.fetchall(),
						   columns=('Ticket Id', 'Last Update'))


@app.route("/close-ticket/", methods=["GET", "POST"])
def close_ticket():
	'''
	Once a ticket has been dealt with it will have to be closed 
	'''
	message = ""

	if request.method == 'POST':
		conn.rollback()
		try:

			query = ("update ticket SET status='closed' where ticketId = %s");

			cursor = conn.cursor()
			cursor.execute(query, [request.form.get('ticketId')])
			conn.commit()

			query = "SELECT ticketId, status FROM ticket WHERE ticketId = %s"
			cursor.execute(query, [request.form.get('ticketId')])
			result = cursor.fetchall()

			if result:
				return render_template("show-results.html", results=result,
									   columns=('Ticket Id', 'Status'))

			message = 'Success'

		except (psycopg2.IntegrityError, psycopg2.DataError) as e:
			conn.rollback()
			print(str(e))
			message = str(e)

	return render_template("close-ticket-form.html", message=message)


@app.route("/ticket-details/", methods=["GET", "POST"])
def cticket_details():
	'''
	The specifics about a given ticket 
	'''
	message = ""

	if request.method == 'POST':
		conn.rollback()
		try:
			cursor = conn.cursor()
			query = ("select t.problem, u.message, case when u.staffId is null THEN "
					 "(select name from customer where customerId = t.customerId) "
					 "else "
					 "(select name from staff where staffId = u.staffId) "
					 "end "
					 "as name, u.updatetime "
					 "from ticket t LEFT join ticketupdate u on t.ticketId = u.ticketid "
					 "where t.ticketId = %s order by updatetime;");

			cursor.execute(query, [request.form.get('ticketId')])
			result = cursor.fetchall()

			if result:
				return render_template("show-results.html",
									   results=[row[1:] for row in result],
									   columns=('message', 'updated by', 'update time'),
									   primary=result[0][0])

			message = 'Success'

		except (psycopg2.IntegrityError, psycopg2.DataError) as e:
			conn.rollback()
			print(str(e))
			message = str(e)

	return render_template("ticket-detail-form.html", message=message)


@app.route("/show-closed-tickets/", methods=["GET"])
def show_closed_tickets():
	'''
	show all tickets which have been resolved
	'''
	message = ""
	cursor = conn.cursor()
	query = ("select ticketId, loggedtime, first - loggedTime , last - loggedTime  from "
			 "(select t.ticketId, t.loggedtime,  "
			 "(select min(updatetime) from ticketupdate where ticketId = t.ticketid) as first, "
			 "(select max(updatetime) from ticketupdate where ticketId = t.ticketid) as last "
			 "from ticket t inner join ticketupdate u on t.ticketId = u.ticketId "
			 "where t.status = 'closed' group by t.ticketId) as A order by ticketId;")
	cursor.execute(query)

	return render_template("show-results.html", results=cursor.fetchall(),
						   columns=('Ticket Id', 'Opened at', 'First response', 'Last response'))


@app.route("/delete-customer/", methods=["GET", "POST"])
def delete_customer():
	'''
	Ends a ticket 
	'''
	message = ""

	if request.method == 'POST':
		conn.rollback()
		try:
			cursor = conn.cursor()
			query = ("delete from customer where customerId = %s ");
			cursor.execute(query, [request.form.get('customerId')])
			conn.commit()

			message = 'Success'

		except (psycopg2.IntegrityError, psycopg2.DataError) as e:
			conn.rollback()
			print(str(e))
			message = str(e)

	return render_template("delete-customer-form.html", message=message)



if __name__ == "__main__":
	app.run (debug = True)