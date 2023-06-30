class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.string :name
      t.string :measurement_unit
      t.float :price
      t.integer :quantity

      t.timestamps
    end
  end
end
