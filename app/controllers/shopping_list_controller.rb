class ShoppingListController < ApplicationController
  def index
    @foods = CartItem.all
  end

  def generate
    @recipe = Recipe.find(params[:recipe_id])
    @recipe.recipe_foods.each do |recipe_food|
      food = recipe_food.food
      CartItem.create(
        name: food.name,
        measurement_unit: food.measurement_unit,
        price: food.price,
        quantity: recipe_food.quantity,
        recipe: @recipe
      )
    end

    redirect_to shopping_list_path, notice: 'Shopping list generated successfully.'
  end
end
