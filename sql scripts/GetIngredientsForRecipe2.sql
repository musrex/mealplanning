DELIMITER //

CREATE PROCEDURE GetIngredientsForRecipe(IN recipe_name VARCHAR(100))
BEGIN
    SELECT i.IngredientName, i.IngredientType
    FROM Ingredients i
    JOIN Meal m ON i.Id = m.IngredientId
    WHERE m.RecipeName = recipe_name;
END //

DELIMITER ;