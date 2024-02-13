require 'ingredient_processor'

namespace :import do
  desc 'Imports external source recipes data from json to postgresql'
  recipes = []
  task :recipe_dataset => :environment do
    data = JSON.parse(File.read('./recipes-en.json'))
    bar = ProgressBar.new(data.count+1)

    data.each do |r_data|
      recipe = {
        title:     r_data['title'],
        cook_time: r_data['cook_time'],
        prep_time: r_data['prep_time'],
        ratings:   r_data['ratings'].to_f,
        cuisine:   r_data['cuisine'],
        image_url: r_data['image']
      }

      # Load author
      recipe[:author_id] = Author.find_or_create_by(name: r_data['author'])[:id]

      # Load category
      recipe[:category_id] = Category.find_or_create_by(name: r_data['category'])[:id]

      load_ingredients(recipe, r_data['ingredients'])

      recipes << Recipe.new(recipe)
      bar.increment!
    end
    Recipe.import(recipes, recursive: true)
    bar.increment!
  end

  def load_ingredients(recipe, ingredients_data)
    recipe[:recipe_ingredients_attributes] = []

    ingredients_data.each do |i_data|
      ri = {}
      processor = IngredientProcessor.new(i_data)
      ri[:ingredient_id] = Ingredient.find_or_create_by(name: processor.ingredient)[:id]

      # Edge case on recipes data for repeating ingredients
      next if recipe[:recipe_ingredients_attributes].pluck(:ingredient_id).include? ri[:ingredient_id]

      ri[:quantity_id] = Quantity.find_or_create_by(amount: processor.amount, extra: processor.extra)[:id] if processor.amount
      ri[:measurement_unit_id] = MeasurementUnit.find_or_create_by(name: processor.measurement_unit)[:id] if processor.measurement_unit

      recipe[:recipe_ingredients_attributes] << ri
    end
  end
end
