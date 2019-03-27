from wtforms import Form, TextField, TextAreaField, validators, StringField, SubmitField, IntegerField

class CustomerForm(Form):
    customer_id = IntegerField()
    name = StringField()
    email = StringField()
    