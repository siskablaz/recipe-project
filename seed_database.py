"""Script to seed database."""
import requests
import os
import json
from random import choice, randint
from datetime import datetime

import crud
import model
import server

os.system("dropdb recipes")
os.system('createdb recipes')

model.connect_to_db(server.app)
model.db.create_all()

res = requests.get('https://api.spoonacular.com/recipes/findByIngredients?apiKey=e7716122fcea490aa1c5a7f3c8a9b7e2&ingredients=apples,flour,sugar,&number=100')

recipe_results = res.json()

recipes_in_db = []
for recipe in recipe_results:
    id, image, image_type, likes, missed_ingredient_count, missed_ingredients, 
    title, unused_ingredients, used_ingredient_count, used_ingredients = (
        movie["id"],
        movie["image"],
        movie["imageType"],
        movie["likes"],
        movie["missedIngredientCount"],
        movie["missedIngredients"],
        movie["title"],
        movie["unusedIngredients"],
        movie["usedIngredientCount"],
        movie["usedIngredients"]
    )

    db_recipe = crud.create_recipe(id, image, image_type, likes, missed_ingredient_count, 
    missed_ingredients, title, unused_ingredients, used_ingredient_count, used_ingredients)
    
    recipes_in_db.append(db_recipe)

model.db.session.add_all(recipes_in_db)
model.db.session.commit()

for n in range(10):
    email = f"user{n}@test.com"  
    password = "test"

    user = crud.create_user(email, password)
    model.db.session.add(user)

    for i in range(10):
       
        fav_recipe = crud.create_fav_recipe(i+1, user)
        model.db.session.add(fav_recipe)

model.db.session.commit()


