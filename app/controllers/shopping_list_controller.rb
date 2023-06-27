class ShoppingListController < ApplicationController
  def index
    @foods = session[:foods]
  end
end
