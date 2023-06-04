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

res = requests.get(f'https://api.spoonacular.com/recipes/complexSearch?apiKey=e7716122fcea490aa1c5a7f3c8a9b7e2&includeIngredients=flour,sugar&addRecipeInformation=true&fillIngredients=true&instructionsRequired=true&sort=min-missing-ingredients&number=10')
# https://api.spoonacular.com/recipes/findByIngredients?apiKey=e7716122fcea490aa1c5a7f3c8a9b7e2&ingredients=apples,flour,sugar&number=1
recipe_results = res.json()
recipe_results = recipe_results["results"]


recipe_id_list = []
recipes_in_db = []
for recipe in recipe_results:
    recipe_id, image, image_type, likes, missed_ingredient_count, missed_ingredients, title, instructions,ingredients, ready_minutes = (
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
        ingredient_name = ingredient["name"].replace("''",""''"")
        ingredient_name = ingredient_name.replace("'","")
        missed_ingredients_list.append(ingredient_name)
    
    print(missed_ingredients_list)
    



    analyzed_instructions_list =[]
    for instruction in instructions:
        for step in instruction["steps"]:
            analyzed_instructions_list.append(step["step"])

    ingredients_list = []
    for ingredient in ingredients:
        ingredients_list.append(f'{ingredient["originalName"]}: {ingredient["amount"]} {ingredient["unit"]}')
        # ingredient.image
        # imgredient.originalName

        # ("Name", "Location", "color")
        # [Firstthing, Secondthing, Thirdthing]
        # "Name, Location, color"
        # split on the comma to pull out data?

    recipe_id_list.append(recipe_id)


    db_recipe = crud.create_recipe(recipe_id, image, image_type, likes, missed_ingredient_count, 
    missed_ingredients_list, title, analyzed_instructions_list, ingredients_list, ready_minutes)
    
    recipes_in_db.append(db_recipe)




model.db.session.add_all(recipes_in_db)
model.db.session.commit()

sample_comments = ['Awesome Recipe!', 'Tasted Bad', "Didn't look like the picture", 'Tasted Amazing!','Loved it!!!','Hated it!!!','Cant wait to make again', 'It was mid', 'best recipe eveeer','Just alright']
sample_scores = [5,1,3,5,3,4,5,2,3,1]


for n in range(10):
    email = f"user{n}"  
    password = "test"
    count = 0

    user = crud.create_user(email, password)


    for i in range(10):
       
        fav_recipe = crud.create_fav_recipe(recipes_in_db[i].recipe_id, user.user_id)
        model.db.session.add(fav_recipe)
    
for recipe in recipe_id_list:
    recipe_id = recipe
    for i in range(10):
        comment = sample_comments[i]
        score = sample_scores[i]
        count = count + 1
        rating_sample = crud.create_rating(score, comment, count, recipe_id, user.user_id)
        model.db.session.add(rating_sample)



model.db.session.commit()


