from model import db, User, Rating, Fav_recipe, Shopping_list, Ingredient, Recipe, connect_to_db
import model

def create_user(email, password):
    """Create and return a new user."""

    user = User(email=email, password=password)

    return user


def get_user_by_email(email):
    """Return a user by email."""

    return User.query.filter(User.email == email).first()

def create_recipe(recipe_id, image, image_type, likes, missed_ingredient_count, 
    missed_ingredients, title, instructions, ingredients, ready_minutes):

    recipe = Recipe(recipe_id=recipe_id, image=image, image_type=image_type, 
    likes=likes, missed_ingredient_count=missed_ingredient_count, 
    missed_ingredients=missed_ingredients, title=title,
     instructions=instructions, ingredients=ingredients, ready_minutes=ready_minutes)

    return recipe

def get_recipe_by_id(recipe_id):

    return Recipe.query.filter(Recipe.recipe_id == recipe_id).first()
    


def create_fav_recipe(recipe_id, user_id):
    """Create and return a new recipe."""

    fav_recipe = Fav_recipe(recipe_id=recipe_id, user_id=user_id)

    return fav_recipe


def is_recipe_in_favorite(user_id, recipe_id):
    """Return a Fav_recipe object given user id and recipe id"""
     
    return Fav_recipe.query.filter((Fav_recipe.user_id == user_id) & (Fav_recipe.recipe_id == recipe_id)).first() 


def get_users_fav_recipes(user_id):

    users_favs = Fav_recipe.query.filter(Fav_recipe.user_id == user_id).all()
    
    recipes = []
    for fav_recipe in users_favs:
        recipes.append((Recipe.query.filter(Recipe.recipe_id == fav_recipe.recipe_id).first()))
            
    return recipes

def create_recipe_api(recipe_response):
    
    recipes_in_db = []
    for recipe in recipe_response:
        recipe_id, image, image_type, likes, missed_ingredient_count, 
        missed_ingredients, title, instructions, ingredients = (
            recipe["id"],
            recipe["image"],
            recipe["imageType"],
            recipe["likes"],
            recipe["missedIngredientCount"],
            recipe["missedIngredients"],
            recipe["title"],
            recipe["analyzedInstructions"],
            recipe["extendedIngredients"]
        
        )
    
        missed_ingredients_list = []
        for ingredient in missed_ingredients:
            missed_ingredients_list.append(ingredient["name"].replace('"',' '))


        analyzed_instructions_list =[]
        for instruction in instructions:
            for step in instruction["steps"]:
                analyzed_instructions_list.append(step["step"])

        ingredients_list = []
        for ingredient in ingredients:
            ingredients_list.append(ingredient["originalName"])

        db_recipe = create_recipe(recipe_id, image, image_type, likes, missed_ingredient_count, 
        missed_ingredients_list, title, analyzed_instructions_list, ingredients_list)
        
        recipes_in_db.append(db_recipe)


    model.db.session.add_all(recipes_in_db)
    model.db.session.commit()

    return recipes_in_db



def get_recipes(recipe_response):

    # recipes_list = []
    recipes_list = Recipe.query.filter(Recipe.missed_ingredient_count == 4).all()
    # for miss_ingredients in all_miss_ingredients:
    #     if ingredients.in_(miss_ingredients):
    return recipes_list


def create_shopping_list(user_id):

    shop_list = Shopping_list(user_id = user_id)
    return shop_list


def create_ingredient(name,complete,shopping_list_id):

    ingredient = Ingredient(name=name,complete=complete,shopping_list_id=shopping_list_id)
    return ingredient



def get_ingredient_by_shopping_list_id(shopping_list_id):

    return Ingredient.query.filter(Ingredient.shopping_list_id == shopping_list__id).first()



def in_shopping_list_by_name(shopping_list_id, ingredient_name):

    return Ingredient.query.filter((Ingredient.name == ingredient_name) & (Ingredient.shopping_list_id == shopping_list_id)).first()


    



def get_shopping_list_by_user_id(user_id):
    
    return Shopping_list.query.filter(Shopping_list.user_id == user_id).first()


def get_rating_by_recipe_user(recipe_id,user_id):

    return Rating.query.filter((Rating.recipe_id == recipe_id) & (Rating.user_id == user_id)).first()



def get_rating_by_id(rating_id):

    return Rating.query.filter(Rating.rating_id == rating_id).first()


def get_all_recipe_ratings(recipe_id):

    return Rating.query.filter(Rating.recipe_id == recipe_id).all()
     


def create_rating(score, comment, count, recipe_id, user_id):
    """Create and return a new rating."""

    rating = Rating(score=score, comment=comment, count=count, recipe_id=recipe_id, user_id=user_id)

    return rating

def update_rating(rating_id, new_score, new_comment):
    """ Update a rating given rating_id and the updated score. """
    rating = Rating.query.get(rating_id)
    rating.score = new_score
    rating.comment = new_comment


def get_avg_rating(recipe_ratings_list):

  
    sum_of_ratings = 0
    for rating in recipe_ratings_list:
        print(rating.score)
        sum_of_ratings += rating.score
    return sum_of_ratings/len(recipe_ratings_list)


def add_recipes_to_db(res):

    recipe_results = res.json()
    recipe_results = recipe_results["results"]



    recipes_in_db = []
    return_recipes = []
    for recipe in recipe_results:
        recipe_id, image, image_type, likes, missed_ingredient_count, missed_ingredients, title, instructions, ingredients, ready_minutes = (
            recipe["id"],
            recipe["image"],
            recipe["imageType"],
            recipe["likes"],
            recipe["missedIngredientCount"],
            recipe["missedIngredients"],
            recipe["title"],
            recipe["analyzedInstructions"],
            recipe["extendedIngredients"],
            recipe["readyInMinutes"]
        
        )

    #     missed_ingredients => list containing all ingredient objects
    #     {
    #     "aisle": "Baking",
    #     "amount": 1.0,
    #     "id": 18371,
    #     "image": "https://spoonacular.com/cdn/ingredients_100x100/white-powder.jpg",
    #     "meta": [],
    #     "name": "baking powder",
    #     "original": "1 tsp baking powder",
    #     "originalName": "baking powder",
    #     "unit": "tsp",
    #     "unitLong": "teaspoon",
    #     "unitShort": "tsp"
    # },
        missed_ingredients_list = []
        for ingredient in missed_ingredients:
            missed_ingredients_list.append(ingredient["name"].replace("''",""))
           

        analyzed_instructions_list =[]
        for instruction in instructions:
            for step in instruction["steps"]:
                analyzed_instructions_list.append(step["step"])

        ingredients_list = []
        for ingredient in ingredients:
            ingredients_list.append(ingredient["originalName"])
            # ingredient.image
            # imgredient.originalName

            # ("Name", "Location", "color")
            # [Firstthing, Secondthing, Thirdthing]
            # "Name, Location, color"
            # split on the comma to pull out data?

        recipe_in_db = Recipe.query.filter(Recipe.recipe_id == recipe_id).first()
        

        

        if not recipe_in_db:
            db_recipe = create_recipe(recipe_id, image, image_type, likes, missed_ingredient_count, 
            missed_ingredients_list, title, analyzed_instructions_list, ingredients_list, ready_minutes)


            
            recipes_in_db.append(db_recipe)
            return_recipes.append(db_recipe)

        else:
            return_recipes.append(recipe_in_db)
    



    model.db.session.add_all(recipes_in_db)
    model.db.session.commit()

    return return_recipes




if __name__ == "__main__":
    from server import app

    connect_to_db(app)