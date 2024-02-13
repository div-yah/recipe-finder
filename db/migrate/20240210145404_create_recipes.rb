class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :title, null: false
      t.integer :cook_time
      t.integer :prep_time
      t.decimal :ratings, precision: 3, scale: 2
      t.string :cuisine
      t.string :image_url

      t.references :author
      t.references :category

      t.timestamps
    end
  end
end
