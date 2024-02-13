class CreateRecipeIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_ingredients do |t|
      t.references :recipe
      t.references :ingredient
      t.references :quantity
      t.references :measurement_unit

      t.timestamps
    end
  end
end
