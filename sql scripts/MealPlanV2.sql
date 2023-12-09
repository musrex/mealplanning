DROP DATABASE IF EXISTS MealPlanning;
CREATE DATABASE MealPlanning;
USE MealPlanning;

CREATE TABLE Cookbook (
    CookbookName varchar(200) NOT NULL,
    IsBook bool NOT NULL,
    Website varchar(200),
    PRIMARY KEY (CookbookName)
);

CREATE TABLE Recipe (
    RecipeName varchar(100) NOT NULL,
    CookbookName varchar(200) NOT NULL,
    TotalServings int,
    PRIMARY KEY (RecipeName),
    FOREIGN KEY (CookbookName) REFERENCES Cookbook (CookbookName) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Ingredients (
    Id int NOT NULL AUTO_INCREMENT,
    IngredientName varchar(100) NOT NULL,
    IngredientType varchar(100),
    PRIMARY KEY (Id)
);

CREATE TABLE Allergens (
	Id int NOT NULL AUTO_INCREMENT,
    AllergenName varchar(100) NOT NULL,
    PRIMARY KEY (Id)
);

CREATE TABLE IngredientAllergens (
	IngredientId int NOT NULL,
    AllergenId int NOT NULL,
    PRIMARY KEY (IngredientId, AllergenId),
    FOREIGN KEY (IngredientId) REFERENCES Ingredients (Id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (AllergenId) REFERENCES Allergens (Id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Meal (
    RecipeName varchar(100) NOT NULL,
    IngredientId int NOT NULL,
    PRIMARY KEY (RecipeName, IngredientId),
    FOREIGN KEY (RecipeName) REFERENCES Recipe (RecipeName) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (IngredientId) REFERENCES Ingredients (Id) ON UPDATE CASCADE ON DELETE CASCADE
);