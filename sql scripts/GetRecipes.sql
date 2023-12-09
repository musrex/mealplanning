DELIMITER $$

CREATE PROCEDURE GetRecipesInCookbook(myCookBookName VARCHAR(200))
BEGIN
    SELECT * FROM Recipe
    WHERE CookbookName = myCookBookName;
END$$

DELIMITER ;
