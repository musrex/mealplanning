document.addEventListener('DOMContentLoaded', function() {
    // Retrieve recipes from cookbooks
    document.getElementById('cookbook_categories').addEventListener('change', function(){
        var selectedCookbook = this.value;
        fetch('/get_recipes/' + selectedCookbook)
            .then(response => response.json())
            .then(recipes => {
                console.log("Recipes:", recipes);
                var recipeDropdown = document.getElementById('recipe_dropdown');
                recipeDropdown.innerHTML = '<option value="" selected>Recipes</option>';
                recipes.forEach(function(recipe) {
                    var option = document.createElement('option');
                    option.value = recipe.RecipeName;
                    option.textContent = recipe.RecipeName;
                    recipeDropdown.appendChild(option);
                });
            })
            .catch(error => console.error('Error fetching recipes:', error))
    });

    // Retrieve ingredients
    document.getElementById('recipe_dropdown').addEventListener('change', function(){
        var selectedRecipe = this.value;
        fetch('/get_ingredients/' + selectedRecipe)
            .then(response => response.json())
            .then(ingredients => {
                console.log("Ingredients:", ingredients);
                var ingredientsList = document.getElementById('ingredients_list');
                ingredientsList.innerHTML = '';

                var heading = document.createElement('h2');
                heading.textContent = selectedRecipe + ':';
                ingredientsList.appendChild(heading);

                ingredients.forEach(function(ingredient) {
                    var listItem = document.createElement('li');
                    listItem.textContent = ingredient.IngredientName + ', ' + ingredient.IngredientType;
                    ingredientsList.appendChild(listItem);
                });

                // Create the Save Recipe button
                var saveButton = document.createElement('button');
                saveButton.textContent = 'Save Recipe';
                saveButton.addEventListener('click', function() {
                    var ingredientList = ingredients.map(ingredient => ingredient.IngredientName);
                    fetch('/add_recipe', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({ recipeName: selectedRecipe, ingredients: ingredientList }),
                    })
                    .then(response => response.json())
                    .then(data => console.log("Recipe saved:", data))
                    .catch(error => console.error('Error:', error));
                });

                // Append the button to the DOM
                ingredientsList.appendChild(saveButton);
            })
            .catch(error => console.error('Error fetching ingredients:', error));
    });

});

