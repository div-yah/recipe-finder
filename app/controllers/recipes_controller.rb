class RecipesController < ApplicationController
  def search
    @recipes = Recipe.search_ingredients(params[:ingredient_ids]) if params[:ingredient_ids]
  end

  def show
    @recipe = Recipe.includes(
                :category,
                recipe_ingredients: [:ingredient, :quantity, :measurement_unit]
              ).find(params[:id])
  end
end
