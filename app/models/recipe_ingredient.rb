class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient
  belongs_to :quantity, optional: true
  belongs_to :measurement_unit, optional: true
end
