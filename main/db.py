import mysql.connector
from flask import current_app, g

class DatabaseAccess:
    def __init__(self):
        self.connection = mysql.connector.connect(
            host=current_app.config['MYSQL_HOST'],
            user=current_app.config['MYSQL_USER'],
            password=current_app.config['MYSQL_PASSWORD'],
            database=current_app.config['MYSQL_DB']
        )
        self.cursor = self.connection.cursor(dictionary=True)

    def close(self):
        self.cursor.close()
        self.connection.close()

    # Example function - adjust according to your needs
    def get_cookbooks(self):
        self.cursor.callproc('GetCookbooks')
        results = []
        for result_set in self.cursor.stored_results():
            results.extend(result_set.fetchall())
        return results

    def get_recipes(self,cookbook):
        self.cursor.callproc('GetRecipesInCookbook',(cookbook,))
        results = []
        for result_set in self.cursor.stored_results():
            results.extend(result_set.fetchall())
        return results 

    def get_ingredients(self, recipe):
        self.cursor.callproc('GetIngredientsForRecipe', (recipe,))
        results = []
        for result_set in self.cursor.stored_results():
            results.extend(result_set.fetchall())
        return results



def get_db():
    if 'db' not in g:
        g.db = DatabaseAccess()
    return g.db

def close_db(e=None):
    db = g.pop('db', None)
    if db is not None:
        db.close()

def init_app(app):
    app.teardown_appcontext(close_db)                
