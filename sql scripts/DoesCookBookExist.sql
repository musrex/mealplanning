  DELIMITER $$

DROP FUNCTION IF EXISTS doesCookbookExist;$$
CREATE FUNCTION doesCookbookExist(myCookBookName VARCHAR(200))
RETURNS BOOLEAN DETERMINISTIC
BEGIN

    -- Let's try another way to see if a cookbook exists,
    DECLARE doesExist bool;    
    SET doesExist = EXISTS 
		(SELECT CookbookName  
		FROM Cookbook
		WHERE CookbookName = myCookBookName);

    RETURN doesExist;

END;$$

DELIMITER ;