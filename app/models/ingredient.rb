class Ingredient < ApplicationRecord
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true

  scope :search, -> (ing) { where("name ILIKE ? ", "%#{ing}%").order("LENGTH(name) ASC").limit(10) }
end
