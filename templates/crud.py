from model import db, User, Movie, Rating, connect_to_db

def get_user_by_email(email):
    """Return a user by email."""

    return User.query.filter(User.email == email).first()