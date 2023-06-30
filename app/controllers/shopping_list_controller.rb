class ShoppingListController < ApplicationController
  def index
    @foods = CartItem.all
  end
end