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

    popular_recipes = crud.get_pop_recipes()
    print(popular_recipes[0]["image"])

    return render_template("homepage.html", popularRecipes = popular_recipes)


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

        return redirect("/register-page")
    else:
        user = crud.create_user(email,password)
        # TODO also create shopping list for user that was created



        flash("Account created! Please log in.")
        print("created new email")
 
        return redirect("/login-page")
    


@app.route('/login', methods=["POST"])
def process_login():

    email = request.form.get("email")
    password = request.form.get("password")

    print(email)
    

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


@app.route('/login-page')
def login_page():

    return render_template("login.html")

@app.route('/register-page')
def register_page():

    return render_template("register.html")


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

@app.route('/logout')
def logout():

    session.clear()

    flash('You have been logged out successfully.')
    return redirect('/')
   

#     return render_template("recipe_results.html", recipes=recipes)
@app.route("/b-get-db-recipes")
def show_db_recipes_bootstrap():
     
    logged_in_email = session.get("user_email")
    user = crud.get_user_by_email(logged_in_email)

    recipes = crud.get_users_fav_recipes(user.user_id)

    curr_shop_list = []
    
    for listobject in user.shopping_list:
        for ingobject in listobject.ingredient:
            curr_shop_list.append(ingobject.name)

    curr_fav_recipes = []

    for recobj in user.fav_recipes:
        curr_fav_recipes.append(recobj.recipe_id)

    print(recipes)
    print(recipes)
    print(recipes)
    print(curr_shop_list)

    return render_template("B_results_page.html", recipes=recipes, user=user, currShopList=curr_shop_list, currFavRecipes = curr_fav_recipes)


@app.route("/get-db-recipes", methods=['POST'])
def show_db_recipes():
 
    recipe_input = request.form.get("recipe-input")
    recipe_input = recipe_input.replace(", ",",")
    recipe_input = recipe_input.replace(" ","%20")


    diet_input = request.form.get("diet")

    intolerance_input = request.form.get("intolerance")   

    dish_type_input = request.form.get("dish-type")  

    time_input = request.form.get("time")
    
    print(f'https://api.spoonacular.com/recipes/complexSearch?apiKey=e7716122fcea490aa1c5a7f3c8a9b7e2&includeIngredients={recipe_input}&diet={diet_input}&intolerances={intolerance_input}&query={dish_type_input}&maxReadyTime={time_input}&addRecipeInformation=true&fillIngredients=true&instructionsRequired=true&sort=min-missing-ingredients&number=10')

    res = requests.get(f'https://api.spoonacular.com/recipes/complexSearch?apiKey=e7716122fcea490aa1c5a7f3c8a9b7e2&includeIngredients={recipe_input}&diet={diet_input}&intolerances={intolerance_input}&query={dish_type_input}&maxReadyTime={time_input}&addRecipeInformation=true&fillIngredients=true&instructionsRequired=true&sort=min-missing-ingredients&number=10')
  
    
    recipes = crud.add_recipes_to_db(res)

    logged_in_email = session.get("user_email")

    if logged_in_email is None:
        curr_shop_list = []
        curr_fav_recipes = []
        user = None

    else:
        user = crud.get_user_by_email(logged_in_email)


        curr_shop_list = []
        
        for listobject in user.shopping_list:
            for ingobject in listobject.ingredient:
                curr_shop_list.append(ingobject.name)

        

        curr_fav_recipes = []

        for recobj in user.fav_recipes:
            curr_fav_recipes.append(recobj.recipe_id)
   



   

    return render_template("recipe_results.html", recipes=recipes, user=user, currShopList=curr_shop_list, currFavRecipes = curr_fav_recipes)




    # crud.create_recipe_api(recipes)

    return render_template("homepage.html")

@app.route("/get-recipes")
def show_recipes():
    ingredients = request.args.get("recipe")

    recipes = crud.get_recipes(ingredients)

    return render_template("recipe_results.html", recipes=recipes)



@app.route("/is-favorite-react", methods=['POST'])
def is_favorite_react():
    logged_in_email = session.get("user_email")
    recipe_id = request.json.get("recipeId")
  

    if logged_in_email is None:
    
        return "white"
    else:
        user = crud.get_user_by_email(logged_in_email)
        this_user_id = user.user_id
       
        in_favorite = crud.is_recipe_in_favorite(this_user_id,recipe_id)
        recipe = crud.get_recipe_by_id(recipe_id)
        recipe_name = crud.get_recipe_by_id(recipe_id).title
        
        print(in_favorite)
        is_favorite = None
        if in_favorite:
      
            return "red"
                # or can return as json jsonify({key:value,key:value,key:value})
        else:
      
            return "white"





@app.route("/add-favorite-react", methods=['POST'])
def add_favorite_react():
    logged_in_email = session.get("user_email")
    recipe_id = request.json.get("recipeId")
  
    print(recipe_id)
    print(recipe_id)
    print(recipe_id)
    print(recipe_id)
    print(recipe_id)
    print(recipe_id)
    print(recipe_id)
    print(recipe_id)
    print(recipe_id)

    if logged_in_email is None:
        
        return "You must log in to save a recipe to favorites"
    else:
        user = crud.get_user_by_email(logged_in_email)
        this_user_id = user.user_id
       
        in_favorite = crud.is_recipe_in_favorite(this_user_id,recipe_id)
        recipe = crud.get_recipe_by_id(recipe_id)
        recipe_name = crud.get_recipe_by_id(recipe_id).title
        
        print(in_favorite)
        is_favorite = None
        if in_favorite:
            
            db.session.delete(in_favorite)
            db.session.commit()
            print('removing')
            print(in_favorite)
            is_favorite = False
      
            return (f'Removing from Favorites')
                # or can return as json jsonify({key:value,key:value,key:value})
        else:
            fav_recipe = crud.create_fav_recipe(recipe_id, this_user_id)

            db.session.add(fav_recipe)
            db.session.commit()
            is_favorite = True

            print(f'adding {fav_recipe}')
      
            return (f'Adding to Favorites')




@app.route("/add-favorite", methods=['POST'])
def add_favorite():
    # recipe_id = request.form.get("fav-button")
    print(request.json)
    logged_in_email = session.get("user_email")
    recipe_id = request.json.get("recipeId")
    page = request.json.get("page")

    if logged_in_email is None:
        flash("You must log in to save a recipe to favorites")
        return "You must log in to save a recipe to favorites"
    else:
        user = crud.get_user_by_email(logged_in_email)
        this_user_id = user.user_id
       
        in_favorite = crud.is_recipe_in_favorite(this_user_id,recipe_id)
        recipe = crud.get_recipe_by_id(recipe_id)
        recipe_name = crud.get_recipe_by_id(recipe_id).title
        
        print(in_favorite)
        is_favorite = None
        if in_favorite:
            
            recipe.likes -= 1
            db.session.delete(in_favorite)
            db.session.commit()
            print('removing')
            print(in_favorite)
            is_favorite = False
            if page == "fav_page":
                return (f'Removing')
            else:
                return (f'Removing from Favorites')
                # or can return as json jsonify({key:value,key:value,key:value})
        else:
            fav_recipe = crud.create_fav_recipe(recipe_id, this_user_id)
            recipe.likes += 1
         
            db.session.add(fav_recipe)
            db.session.commit()
            is_favorite = True

            print(f'adding {fav_recipe}')
      
            
            if page == "fav_page":
                return (f'Adding')
            else:
                return (f'Adding to Favorites')


@app.route("/favorites")
def favorites_page():

    logged_in_email = session.get("user_email")
    user = crud.get_user_by_email(logged_in_email)

    if user is None:
        flash("You must log in to view favorites")
        return redirect("/")
    else:
        user_id = user.user_id


        curr_shop_list = []
    
        for listobject in user.shopping_list:
            for ingobject in listobject.ingredient:
                curr_shop_list.append(ingobject.name)



        curr_fav_recipes = []

        for recobj in user.fav_recipes:
            curr_fav_recipes.append(recobj.recipe_id)

        recipes = crud.get_users_fav_recipes(user_id)
        # Addvariable that says true if recipe is in favorite then add jinja for rendered button to have class favorited if true




    return render_template("favorites.html", user=user, recipes=recipes, currShopList=curr_shop_list, currFavRecipes = curr_fav_recipes)
  


 

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


@app.route("/recipes/<recipe_id>")
def recipe_details(recipe_id):

    # res = requests.get(f'https://api.spoonacular.com/recipes/{recipe_id}/analyzedInstructions?apiKey=e7716122fcea490aa1c5a7f3c8a9b7e2)
    
    recipe_object = crud.get_recipe_by_id(recipe_id)
    logged_in_email = session.get("user_email")
    user = crud.get_user_by_email(logged_in_email)
    if user is None:
        flash("You must log in to view recipe details")
        # This needs to be corrected
        return redirect('/')
    else:
        this_user_id = user.user_id
        all_recipe_ratings = crud.get_all_recipe_ratings(recipe_id)
        all_recipe_comments = crud.all_comments_for_recipe(all_recipe_ratings)


        comments_list = crud.get_comments_by_recipe_id(recipe_id)

        avg_rating = crud.get_avg_rating(all_recipe_ratings)


        recipe_rating_count = crud.get_rating_count_by_recipe(recipe_id)
        
        if len(all_recipe_comments['comments']) > 0:
            recent_comment = all_recipe_comments['comments'][-1]
            recent_score = all_recipe_comments['scores'][-1]
        else:
            recent_comment = "no comments"
            recent_score = "no scores"

        user_rating = crud.get_rating_by_recipe_user(recipe_id,this_user_id)

        recipe_is_rated = crud.recipe_has_rating(recipe_id)

        print(all_recipe_ratings)
        print(all_recipe_comments)

    return render_template("recipe_details.html", recipe_rating_count=recipe_rating_count, recipe_is_rated=recipe_is_rated, recipe=recipe_object, user_rating=user_rating, avg_rating=avg_rating, comments_list=comments_list, all_recipe_comments=all_recipe_comments, recent_comment=recent_comment, recent_score=recent_score)


@app.route("/add-shopping", methods=['POST'])
def add_shopping():
    # recipe_id = request.form.get("fav-button")
    
    logged_in_email = session.get("user_email")
    ingredient_name = request.json.get("ingredientName")
    

    if logged_in_email is None:
        flash("You must be logged in to add to shopping list")
        # This needs to be corrected
        return (f'You must be logged in to add to shopping list')
    else:
        user = crud.get_user_by_email(logged_in_email)
        if user is None:
            flash(f'You must be logged in to add to shopping list')
        # This needs to be corrected
            return (f'You must be logged in to add to shopping list')
        else:
            this_user_id = user.user_id
            shopping_list_id = crud.get_shopping_list_by_user_id(this_user_id).shopping_list_id

            print(shopping_list_id)
            print(ingredient_name)

            in_shopping_list = crud.in_shopping_list_by_name(shopping_list_id,ingredient_name)
        
            
            print(in_shopping_list)
            is_shopping_list = None
            if in_shopping_list:
                
                db.session.delete(in_shopping_list)
                db.session.commit()
                is_shopping_list = False
                
                return (f'Removing from Shopping list')
            else:
                
                ingredient = crud.create_ingredient(ingredient_name, False, shopping_list_id)
                db.session.add(ingredient)
                db.session.commit()
                is_shopping_list = True
                
                return (f'Adding to Shopping list')


@app.route("/shopping-list")
def shopping_list_page():

    logged_in_email = session.get("user_email")
    user = crud.get_user_by_email(logged_in_email)
    
    if user is None:
        flash("You must log in to save a recipe to favorites")
        return redirect("/")

    else:
        user_id = user.user_id

        shopping_list = crud.get_shopping_list_by_user_id(user_id).ingredient

        print(shopping_list)
    




    return render_template("shopping_list_page.html", user=user, shopping_list=shopping_list)


@app.route("/complete-item", methods=['POST'] )
def complete_item():

    logged_in_email = session.get("user_email")
    ingredient_name = request.json.get("ingredientName")

    print(ingredient_name)
    print(ingredient_name)
    print(ingredient_name)

    if logged_in_email is None:
        flash("You must log in to save a recipe to favorites")
        # This needs to be corrected
        return (f'You need to login')
    else:
        user = crud.get_user_by_email(logged_in_email)
        if user is None:
            flash("You must log in to save a recipe to favorites")
        # This needs to be corrected
            
            return (f'You need to login')
        else:
            this_user_id = user.user_id
            shopping_list_id = crud.get_shopping_list_by_user_id(this_user_id).shopping_list_id

            in_shopping_list = crud.in_shopping_list_by_name(shopping_list_id,ingredient_name)
        
            
            print(in_shopping_list)
            print(in_shopping_list)
            print(in_shopping_list)

            is_shopping_list = None
            if in_shopping_list:
                
                db.session.delete(in_shopping_list)
                db.session.commit()
                is_shopping_list = False
                
           
                return ('Removing from Shopping list')
                
            else:
                
                ingredient = crud.create_ingredient(ingredient_name, False, shopping_list_id)
                db.session.add(ingredient)
                db.session.commit()
                is_shopping_list = True
                
           
                return ('Adding to Shopping list')







@app.route("/update_rating", methods=["POST"])
def update_rating():
    rating_id = request.json["rating_id"]
    updated_score = request.json["updated_score"]
    updated_comment = request.json["updated_comment"]
    rating_object = crud.get_rating_by_id(rating_id)
    rating_count = rating_object.count

    crud.update_rating(rating_id, updated_score, updated_comment)
    db.session.commit()


    average_score= crud.get_avg_rating()

    print(average_score)
    print(average_score)
    print(average_score)
    print(average_score)

    return jsonify({'ratingCount':rating_count, 'averageScore':str(average_score), 'updatedComment':updated_comment})





@app.route("/recipes/<recipe_id>/ratings", methods=["POST"])
def create_rating(recipe_id):
    """Create a new rating for the movie."""

    logged_in_email = session.get("user_email")
    rating_score = request.form.get("rating")
    comment = request.form.get("comment-input")



    if logged_in_email is None:
        flash("You must log in to rate a movie.")
    elif not rating_score:
        flash("Error: you didn't select a score for your rating.")


    else:
        
        user = crud.get_user_by_email(logged_in_email)
        recipe = crud.get_recipe_by_id(recipe_id)
        is_rating_by_user = crud.get_rating_by_recipe_user(recipe_id,user.user_id)
        recipe_has__rating = crud.recipe_has_rating(recipe_id)




        if is_rating_by_user:
            is_rating_by_user.score=rating_score
            is_rating_by_user.comment=comment
            db.session.commit()
        else:


            rating = crud.create_rating(int(rating_score), comment, 1, recipe.recipe_id, user.user_id )
            rating.count + 1
            db.session.add(rating)
            db.session.commit()

        flash(f"{user.user_id} rated this movie {rating_score} out of 5.")

    return redirect(f"/recipes/{recipe_id}")

@app.route("/bootstrap")
def view_temp():

    logged_in_email = session.get("user_email")
    user = crud.get_user_by_email(logged_in_email)
    
    if user is None:
        flash("You must log in to save a recipe to favorites")
        return redirect("/")

    else:
        user_id = user.user_id

        shopping_list = crud.get_shopping_list_by_user_id(user_id).ingredient

        print(shopping_list)

    return render_template("B_shopping_list_page.html", user=user, shopping_list=shopping_list)



@app.route("/popular-recipes.json")
def popular_recipes_json():
    pop_recipes = crud.get_pop_recipes()

    logged_in_email = session.get("user_email")

    if logged_in_email is None:
        curr_shop_list = []
        curr_fav_recipes = []
        user = None

    else:
        user = crud.get_user_by_email(logged_in_email)


        curr_shop_list = []
        
        for listobject in user.shopping_list:
            for ingobject in listobject.ingredient:
                curr_shop_list.append(ingobject.name)

        

        curr_fav_recipes = []

        for recobj in user.fav_recipes:
            curr_fav_recipes.append(recobj.recipe_id)

    

    print(pop_recipes)

  
    print(curr_fav_recipes)


    return jsonify({"pop_recipes":pop_recipes, "curr_fav_recipes":curr_fav_recipes})


@app.route("/popular-recipes")
def popular_recipes():

    return render_template("popular_recipes.html")


if __name__ == "__main__":
    connect_to_db(app)
    app.run(debug=True, host="0.0.0.0")