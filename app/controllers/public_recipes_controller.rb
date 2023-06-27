class PublicRecipesController < ApplicationController
  def index
    @recipes = Recipe.includes(:user, :foods).where(public: true)
  end
end
