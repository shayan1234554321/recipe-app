class AddRecipeToCartItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :cart_items, :recipe, null: false, foreign_key: true
  end
end
