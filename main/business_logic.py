from flask import jsonify

class HolidayMenu:
    def __init__(self, recipe_name):
        self.name = recipe_name
        self.source = ""
        self.ingredients = set()
        self.meal_time = ""

    def add_recipe_to_menu(self, ingredient):
        self.ingredients.update(ingredient)

    def remove_ingredient_from_menu(self, ingredient):
        self.ingredients.remove(ingredient)
    
    def add_source(self, source):
        self.source = source

    def add_meal_time(self, time):
        self.meal_time = time

    def get_menu(self):
        return jsonify()

