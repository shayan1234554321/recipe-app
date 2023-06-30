class ShoppingListController < ApplicationController
  def index
    @foods = CartItem.all
  end
  def generate
    @recipe = Recipe.find(params[:recipe_id])
    @recipe.foods.each do |food|
      CartItem.create(name: food.name, measurement_unit: food.measurement_unit, price: food.price, quantity: food.quantity)
    end

    redirect_to shopping_list_path, notice: 'Shopping list generated successfully.'
  end
end
