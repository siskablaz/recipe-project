"""Script to seed database."""
import requests
import os
import json
from random import choice, randint
from datetime import datetime

import crud
import model
import server

os.system('dropdb recipes')
os.system('createdb recipes')

model.connect_to_db(server.app)
model.db.create_all()

res = requests.get(f'https://api.spoonacular.com/recipes/complexSearch?apiKey=e7716122fcea490aa1c5a7f3c8a9b7e2&addRecipeInformation=true&fillIngredients=true&instructionsRequired=true&sort=min-missing-ingredients&number=10')
# https://api.spoonacular.com/recipes/findByIngredients?apiKey=e7716122fcea490aa1c5a7f3c8a9b7e2&ingredients=apples,flour,sugar&number=1
recipe_results = res.json()
recipe_results = recipe_results["results"]

recipes_in_db = []
for recipe in recipe_results:
    recipe_id, image, image_type, likes, missed_ingredient_count, missed_ingredients, title, instructions,ingredients = (
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
        missed_ingredients_list.append(ingredient["name"])


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


    db_recipe = crud.create_recipe(recipe_id, image, image_type, likes, missed_ingredient_count, 
    missed_ingredients_list, title, analyzed_instructions_list, ingredients_list)
    
    recipes_in_db.append(db_recipe)



model.db.session.add_all(recipes_in_db)
model.db.session.commit()

for n in range(10):
    email = f"user{n}@test.com"  
    password = "test"

    user = crud.create_user(email, password)
    model.db.session.add(user)
    model.db.session.commit()

    for i in range(10):
       
        fav_recipe = crud.create_fav_recipe(recipes_in_db[i].recipe_id, user.user_id)
        model.db.session.add(fav_recipe)

model.db.session.commit()


