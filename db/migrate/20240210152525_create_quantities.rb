class CreateQuantities < ActiveRecord::Migration[7.1]
  def change
    create_table :quantities do |t|
      t.decimal :amount, precision: 10, scale: 5
      t.string  :extra

      t.timestamps
    end
  end
end
