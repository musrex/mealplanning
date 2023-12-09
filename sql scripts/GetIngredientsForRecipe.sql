DELIMITER $$

CREATE PROCEDURE GetIngredientsForRecipe(myRecipeName VARCHAR(100))
BEGIN
    SELECT Ingredients.*
    FROM Ingredients
    JOIN Meal ON Ingredients.Id = Meal.IngredientId
    WHERE Meal.RecipeName = myRecipeName;
END$$

DELIMITER ;
