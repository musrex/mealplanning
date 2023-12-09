USE MealPlanning;

-- Let's check and see if the procedure exists, and drop it, before we change the delimiter
-- This is really a single statement we want to run right now. We don't need to group it 
-- with the create procedure statements. And actually, if we did that, we might run into issues when
-- we run this query file. 
DROP PROCEDURE IF EXISTS InsertNewRecipe;

delimiter $$
    CREATE PROCEDURE InsertNewRecipe (
		myRecipeName varchar(100),  -- Note the size I chose for the parameter matches the Recipe tables column size!
        myCookBookName varchar(200), -- Also note my parameters have names that are distinct!
        myTotalServings int,
        myIsBook bool,
        myWebsite varchar(200))
    BEGIN
    
-- Call my function!
if (select doesCookbookExist(myCookBookName) = false ) then
insert into Cookbook  (cookbookName, isBook, Website) values (myCookBookName, myIsBook, myWebsite);
end if;

-- More of the same
if (select doesRecipeExist(myRecipeName) = false) then
insert into Recipe (RecipeName, CookbookName, TotalServings) values (myRecipeName, myCookBookName, myTotalServings);
end if;

    END $$
    delimiter ;