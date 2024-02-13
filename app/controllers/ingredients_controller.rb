class IngredientsController < ApplicationController
  def search
    @ingredients = Ingredient.search(params[:query])

    render json: @ingredients
  end
end
