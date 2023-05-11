from model import db, User, Fav_recipe, Shopping_list, Ingredient, Recipe, connect_to_db

def create_user(email, password):
    """Create and return a new user."""

    user = User(email=email, password=password)

    return user


def get_user_by_email(email):
    """Return a user by email."""

    return User.query.filter(User.email == email).first()

def create_recipe(recipe_id, image, image_type, likes, missed_ingredient_count, 
    missed_ingredients, title):

    recipe = Recipe(recipe_id=recipe_id, image=image, image_type=image_type, 
    likes=likes, missed_ingredient_count=missed_ingredient_count, 
    missed_ingredients=missed_ingredients, title=title)

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



def get_recipes():

    # recipes_list = []
    recipes_list = Recipe.query.filter(Recipe.missed_ingredient_count == 4).all()
    # for miss_ingredients in all_miss_ingredients:
    #     if ingredients.in_(miss_ingredients):
    return recipes_list



if __name__ == "__main__":
    from server import app

    connect_to_db(app)