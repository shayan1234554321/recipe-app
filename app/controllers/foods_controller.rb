class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = current_user.foods
  end

  def create
    @food = current_user.foods.build(food_params)
    if @food.save
      redirect_to foods_path, notice: 'Food created successfully.'
    else
      render :new
    end
  end

  def destroy
    @food = current_user.foods.find(params[:id])
    @food.destroy
    redirect_to foods_path, notice: 'Food deleted successfully.'
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
