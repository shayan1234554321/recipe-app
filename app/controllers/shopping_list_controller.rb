class ShoppingListController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = CartItem.where(user: current_user)
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
        recipe: @recipe,
        user: current_user
      )
    end

    redirect_to shopping_list_path, notice: 'Shopping list generated successfully.'
  end
end
