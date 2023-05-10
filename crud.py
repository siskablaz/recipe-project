from model import db, User, Fav_recipe, Shopping_list, Ingredient, connect_to_db

def create_user(email, password):
    """Create and return a new user."""

    user = User(email=email, password=password)

    return user


def get_user_by_email(email):
    """Return a user by email."""

    return User.query.filter(User.email == email).first()


def create_fav_recipe(recipe_id, user_id):
    """Create and return a new recipe."""

    fav_recipe = Fav_recipe(recipe_id=recipe_id, user_id=user_id)

    return fav_recipe

# def get_recipe_by_id(email):
#     """Return a user by email."""

#     return User.query.filter(User.email == email).first()


if __name__ == "__main__":
    from server import app

    connect_to_db(app)