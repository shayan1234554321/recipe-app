class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = current_user.recipes.includes(:foods)
  end

  def show
    @recipe = Recipe.includes(:foods, :user).find(params[:id])
    @foods = @recipe.foods
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

  private

  def recipe_details_params
    params.require(:recipe).permit(:public)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
