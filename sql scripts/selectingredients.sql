USE MealPlanning;

SELECT Ingredients.IngredientName
FROM Ingredients
INNER JOIN Meal ON Ingredients.Id = Meal.IngredientId
INNER JOIN Recipe ON Meal.RecipeName = Recipe.RecipeName
WHERE Recipe.RecipeName = 'Chicken Stew';


