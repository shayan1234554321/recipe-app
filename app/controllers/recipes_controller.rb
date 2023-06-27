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
        redirect_to @recipe, notice: 'Recipe was successfully created.'
      else
        render :new
      end
    end
  
    def destroy
      @recipe = Recipe.find(params[:id])
      @recipe.destroy if @recipe.user == current_user
      redirect_to recipes_path
    end
  
    private
  
    def recipe_params
      params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
    end
  end
  