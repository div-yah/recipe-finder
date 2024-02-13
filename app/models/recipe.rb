class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  belongs_to :author, optional: true
  belongs_to :category, optional: true

  accepts_nested_attributes_for :recipe_ingredients

  def self.search_ingredients(ingredients)
    select(:id, :title, :image_url)
    .joins(:recipe_ingredients)
    .where(recipe_ingredients:{ ingredient_id: ingredients})
    .group("recipes.id").having("count(recipes.id) = ?", ingredients.size)
    .limit(5)
  end

  def full_ingredients
    recipe_ingredients.map do |i|
      # Convert amount to human readable format
      amount = i.quantity ? Fractional.new(i.quantity.amount, to_human: true).to_s : ''

      "#{amount} #{i.measurement_unit&.name || ''} #{i.ingredient.name.capitalize}"
    end
  end
end
