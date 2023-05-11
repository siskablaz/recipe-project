from datetime import datetime
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class User(db.Model):
    """A user."""

    __tablename__ = "users"

    user_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    email = db.Column(db.String, unique=True)
    password = db.Column(db.String)

    fav_recipes = db.relationship("Fav_recipe", back_populates="user")
    shopping_list = db.relationship("Shopping_list", back_populates="user")

    def __repr__(self):
        return f"<User user_id={self.user_id} email={self.email}>"


class Recipe(db.Model):
    """A user."""

    __tablename__ = "recipes"

    recipe_id = db.Column(db.Integer, primary_key=True)
    image = db.Column(db.String)
    image_type = db.Column(db.String(10))
    likes = db.Column(db.Integer)
    missed_ingredient_count = db.Column(db.Integer)
    missed_ingredients = db.Column(db.ARRAY(db.String))
    title = db.Column(db.String)

    fav_recipes = db.relationship("Fav_recipe", back_populates="recipes")

    def __repr__(self):
        return f"<Recipe recipe_id={self.recipe_id}>"


class Fav_recipe(db.Model):
    """A user."""

    __tablename__ = "fav_recipes"

    fav_recipe_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    recipe_id = db.Column(db.Integer, db.ForeignKey("recipes.recipe_id"))
    user_id = db.Column(db.Integer, db.ForeignKey("users.user_id"))

    user = db.relationship("User", back_populates="fav_recipes")
    recipes = db.relationship("Recipe", back_populates="fav_recipes")


    def __repr__(self):
        return f"<Fav_recipe recipe_id={self.recipe_id} user_id={self.user_id}>"

class Shopping_list(db.Model):
    """A user."""

    __tablename__ = "shopping_lists"

    shopping_list_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey("users.user_id"))

    user = db.relationship("User", back_populates="shopping_list")
    ingredient = db.relationship("Ingredient", back_populates="shopping_list")

class Ingredient(db.Model):
    """A user."""

    __tablename__ = "ingredients"

    Ingredient_id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    name = db.Column(db.String(20))
    complete = db.Column(db.Boolean, default=False)
    qty = db.Column(db.Integer)
    shopping_list_id = db.Column(db.Integer, db.ForeignKey("shopping_lists.shopping_list_id"))

    shopping_list = db.relationship("Shopping_list", back_populates="ingredient")




    def __repr__(self):
        return f"<User user_id={self.user_id} email={self.email}>"



def connect_to_db(flask_app, db_uri="postgresql:///recipes", echo=True):
    flask_app.config["SQLALCHEMY_DATABASE_URI"] = db_uri
    flask_app.config["SQLALCHEMY_ECHO"] = echo
    flask_app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

# The database object and flask app object both need to know about eachother
    db.app = flask_app
    db.init_app(flask_app)

    print("Connected to the db!")


if __name__ == "__main__":
    from server import app

    # Call connect_to_db(app, echo=False) if your program output gets
    # too annoying; this will tell SQLAlchemy not to print out every
    # query it executes.

    connect_to_db(app)
