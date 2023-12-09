from flask import Blueprint, render_template, request, jsonify
from .db import get_db
from .business_logic import HolidayMenu

bp = Blueprint('bp', __name__, template_folder='templates')

# where we store our saved recipes for our holiday menu
holiday_menus = []

@bp.route('/')
def cookbooks():
    db = get_db()
    cookbooks = db.get_cookbooks()
    return render_template('index.html', cookbooks=cookbooks)

@bp.route('/get_recipes/<cookbook_name>')
def get_recipes(cookbook_name):
    db = get_db()
    recipes = db.get_recipes(cookbook_name)
    return jsonify(recipes)

@bp.route('/get_ingredients/<recipe_name>')
def get_ingredients(recipe_name):
    db = get_db()
    ingredients = db.get_ingredients(recipe_name)
    return jsonify(ingredients)

@bp.route('/add_recipe', methods=['POST'])
def add_recipe():
    data = request.json
    recipe_name = data['recipeName']
    ingredients = data['ingredients']

    holiday_menu = HolidayMenu(recipe_name)
    holiday_menu.add_recipe_to_menu(ingredients)

    holiday_menus.append(holiday_menu)

    return jsonify({'result': 'success'})

@bp.route('/view_menus')
def view_menus():
    return render_template('view_menus.html', menus=holiday_menus)
