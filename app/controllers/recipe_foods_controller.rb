class RecipeFoodsController < ApplicationController
  def edit_ingredient
    @recipe = Recipe.find(params[:id])
    @food = Food.find(params[:food_id])
    @recipe_food = RecipeFood.find_by(recipe: @recipe, food: @food)
  end

  def update_ingredient
    @recipe = Recipe.find(params[:id])
    @food = Food.find(params[:food_id])
    @recipe_food = RecipeFood.find_by(recipe: @recipe, food: @food)

    if @recipe_food.update(quantity: params[:recipe_food][:quantity])
      redirect_to @recipe, notice: 'Ingredient quantity updated successfully.'
    else
      render :edit_ingredient
    end
  end
end
