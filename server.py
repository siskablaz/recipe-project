from flask import Flask, render_template, request, flash, session, redirect, jsonify
from model import connect_to_db, db
import crud
import requests

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
        # TODO also create shopping list for user that was created

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
        # TODO Add shopping list to session
        flash(f"Welcome back, {user.email}!")
        print("logged in successfully")

    return redirect("/")


# @app.route("/get-recipes.json", methods=['POST'])
# def show_recipes():
#     # recipe_list = []
#     # for recipe in recipeResponse:

#     recipe_response = request.json.get('recipeResponse')
#     print(recipe_response)
#     print(recipe_response)
#     print(recipe_response)
#     print(recipe_response)

#     recipes=[recipe_response,recipe_response]
#     crud.create_recipe_api(recipes)



   

#     return render_template("recipe_results.html", recipes=recipes)

@app.route("/get-db-recipes", methods=['POST'])
def show_db_recipes():
 
    recipe_input = request.form.get("recipe-input")

    print(recipe_input)

    res = requests.get(f'https://api.spoonacular.com/recipes/complexSearch?apiKey=e7716122fcea490aa1c5a7f3c8a9b7e2&includeIngredients={recipe_input}&fillIngredients=true&sort=min-missing-ingredients&number=10')
    
    recipes = crud.add_recipes_to_db(res)

    return render_template("recipe_results.html", recipes=recipes)




    # crud.create_recipe_api(recipes)

   

    return render_template("homepage.html")

@app.route("/get-recipes")
def show_recipes():
    ingredients = request.args.get("recipe")

    recipes = crud.get_recipes(ingredients)

    return render_template("recipe_results.html", recipes=recipes)



@app.route("/add-favorite", methods=['POST'])
def add_favorite():
    # recipe_id = request.form.get("fav-button")
    print(request.json)
    logged_in_email = session.get("user_email")
    recipe_id = request.json.get("recipeId")

    if logged_in_email is None:
        flash("You must log in to save a recipe to favorites")
        # This needs to be corrected
        return (f'You need to login')
    else:
        user = crud.get_user_by_email(logged_in_email)
        this_user_id = user.user_id
       
        in_favorite = crud.is_recipe_in_favorite(this_user_id,recipe_id)
        recipe_name = crud.get_recipe_by_id(recipe_id).title
        
        print(in_favorite)
        is_favorite = None
        if in_favorite:
            
            db.session.delete(in_favorite)
            db.session.commit()
            is_favorite = False
            
            return (f'You removed {recipe_name} from favorites')
        else:
            fav_recipe = crud.create_fav_recipe(recipe_id, this_user_id)
            db.session.add(fav_recipe)
            db.session.commit()
            is_favorite = True
            
            return (f'You added {recipe_name} to favorites')


@app.route("/favorites")
def favorites_page():

    logged_in_email = session.get("user_email")
    user = crud.get_user_by_email(logged_in_email)
    user_id = user.user_id

    recipes = crud.get_users_fav_recipes(user_id)




    return render_template("favorites.html", user=user, recipes=recipes)
  


 

# @app.route("/add-favorite", methods=["POST"])
# def add_favorite():
#     """Create a new recipe."""

#     logged_in_email = session.get("user_email")

#     recipe_id = request.json.get('recipeId')

#     print(recipe_id)
#     # rating_score = request.form.get("rating")

#     if logged_in_email is None:
#         flash("You must log in to save a recipe to favorites")
#         return redirect('/')
#     else:
#         user = crud.get_user_by_email(logged_in_email)
#         this_user_id = user.user_id
#         # left off here trying to delete recipe function!
#         in_favorite = crud.is_recipe_in_favorite(this_user_id,recipe_id)
        
#         print(in_favorite)
#         is_favorite = None
#         if in_favorite:
            
#             db.session.delete(in_favorite)
#             db.session.commit()
#             is_favorite = False
#         else:
#             fav_recipe = crud.create_fav_recipe(recipe_id, this_user_id)
#             db.session.add(fav_recipe)
#             db.session.commit()
#             is_favorite = True



        
 
#     return jsonify({'recipeId': recipe_id,'userId': this_user_id, 'isFavorite':is_favorite})


    


if __name__ == "__main__":
    connect_to_db(app)
    app.run(debug=True, host="0.0.0.0")