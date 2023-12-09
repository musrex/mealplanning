from flask import Flask
from flask_mysqldb import MySQL
import os

# Import the DatabaseAccess class
from .db import DatabaseAccess, init_app as db_init_app

def create_app(test_config=None):
    app = Flask(__name__, instance_relative_config=True)

    app.config.from_mapping(
        SECRET_KEY='dev',
        MYSQL_HOST='127.0.0.1',
        MYSQL_USER='fly',
        MYSQL_PASSWORD='password',
        MYSQL_DB='MealPlanning',
        MYSQL_CURSORCLASS='DictCursor',
    )

    mysql = MySQL(app)

    # Initialize the Database Access Layer
    db_init_app(app)

    from . import view
    app.register_blueprint(view.bp)

    return app

app = create_app()
