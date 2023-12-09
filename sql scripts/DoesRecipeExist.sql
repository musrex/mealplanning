DELIMITER $$

DROP FUNCTION IF EXISTS doesRecipeExist;$$
CREATE FUNCTION doesRecipeExist(myRecipeName VARCHAR(200))
RETURNS BOOLEAN DETERMINISTIC
BEGIN

-- And yet another to way to use variables and null checks
 declare result varchar(200);
  SET result = (SELECT RecipeName FROM Recipe WHERE RecipeName = myRecipeName);
    RETURN (result IS NOT NULL);

END;$$

DELIMITER ;