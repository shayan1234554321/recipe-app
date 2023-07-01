class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [ :show]

  def index
    @recipes = current_user.recipes.includes(:foods)
  end

  def show
    @recipe = Recipe.includes(:foods, :user).find(params[:id])
    @foods = @recipe.foods
    @recipe_food = RecipeFood.new
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy if @recipe.user == current_user
    redirect_to recipes_path
  end

  def update_details
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_details_params)
      redirect_to @recipe, notice: 'Recipe details updated successfully.'
    else
      render :show
    end
  end

  def add_ingredient
    @recipe = Recipe.find(params[:id])
    food_id = recipe_food_params[:food_id]
    if @recipe.recipe_foods.exists?(food_id:)
      redirect_to @recipe, alert: 'Ingredient already exists in the recipe.'
    else
      @recipe_food = @recipe.recipe_foods.build(recipe_food_params)

      if @recipe_food.save
        redirect_to @recipe, notice: 'Ingredient added successfully.'
      else
        @foods = @recipe.foods
        render 'recipes/show'
      end
    end
  end

  def remove_ingredient
    @recipe = Recipe.find(params[:id])
    @food = Food.find(params[:food_id])
    @recipe_food = @recipe.recipe_foods.find_by(food_id: @food.id)

    if @recipe_food.destroy
      redirect_to @recipe, notice: 'Ingredient removed successfully.'
    else
      redirect_to @recipe, alert: 'Failed to remove ingredient.'
    end
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end

  def recipe_details_params
    params.require(:recipe).permit(:public)
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
