from flask import Flask, render_template, request, flash, session, redirect, jsonify
from model import connect_to_db, db
import crud

from jinja2 import StrictUndefined

app = Flask(__name__)
app.secret_key = "dev"
app.jinja_env.undefined = StrictUndefined


import random



FORTUNES = [
    "Tomorrow your code will <b>work properly</b>.",
    "Your day ahead will be <b>full of while loops</b>.",
    "You will wake up one morning and discover you <i>learned recursion in your sleep</i>.",
    "<i>@facebook</i> will retweet an announcement about your Hackbright project.",
    "You will inherit a house in San Francisco.",
    "In the future, your fortune will be wrong.",
]

WEATHER = {
    '94110': {'forecast': 'Rainy, damp, and rich with hipsters.', 'temp': '60F'},
    '99507': {'forecast': 'Warm, balmy, and good for sunbathing.', 'temp': '100F'},
    '94102': {'forecast': 'Delightful, clever, and full of Python.', 'temp': '55F'},
}

DEFAULT_WEATHER = {'forecast': 'Kind of boring.', 'temp': '68F'}

@app.route('/')
def index():
    """Show our index page."""

    return render_template("homepage.html")


@app.route('/fortune')
def fortune():
    """Return a single fortune as a text string (*not* the whole HTML page!)"""

    return random.choice(FORTUNES)


@app.route('/weather.json')
def weather():
    """Return a weather-info dictionary for this zipcode."""

    zipcode = request.args.get('zipcode')
    weather_info = WEATHER.get(zipcode, DEFAULT_WEATHER)
    return jsonify(weather_info)


@app.route('/order-melons.json', methods=['POST'])
def order_melons():
    """Order melons and return a dictionary of result-code and result-msg."""
    melon = request.json.get('melon_type')
    qty = int(request.json.get('qty'))

    if qty > 10:
        result_code = 'ERROR'
        result_text = "You can't buy more than 10 melons"
    elif qty > 0:
        result_code = 'OK'
        result_text = f"You have bought {qty} {melon} melons"
    else:
        result_code = 'ERROR'
        result_text = "You want to buy fewer than 1 melons? Huh?"

    return jsonify({'code': result_code, 'msg': result_text})

@app.route('/users', methods=['POST'])
def register_user():

    email = request.form.get("email")
    password = request.form.get("password")

    # print(crud.get_user_by_email('test@test.test'))
    user = crud.get_user_by_email(email)
    

    if user:
        flash("Cannot create an account with that email. Try again.")
        print("already an email")
    else:
        user = crud.create_user(email,password)
        db.session.add(user)
        db.session.commit()
        flash("Account created! Please log in.")
        print("created new email")

    return redirect("/")

@app.route('/login', methods=["POST"])
def process_login():

    email = request.form.get("email")
    password = request.form.get("password")

    user = crud.get_user_by_email(email)
    if not user or user.password != password:
        flash("The email or password you entered was incorrect.")
        print("already an email or password incorrect")
    else:
        # Log in user by storing the user's email in session
        session["user_email"] = user.email
        flash(f"Welcome back, {user.email}!")
        print("logged in successfully")

    return redirect("/")





    


if __name__ == "__main__":
    connect_to_db(app)
    app.run(debug=True, host="0.0.0.0")