require 'rails_helper'

RSpec.describe 'Food integration tests', type: :feature do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create(name: 'Nick', email: 'nick@example.com', password: '123456', password_confirmation: '123456')
    @food = Food.create(name: 'Apple', user_id: @user.id, measurement_unit: 'grams', price: 10, quantity: 1)
    @recipe = Recipe.create(name: 'Test', preparation_time: '1 hr', cooking_time: '1 hr', description: 'Test',
                            public: true, user_id: @user.id)
    @recipe_food = RecipeFood.create(quantity: 1, recipe_id: @recipe.id, food_id: @food.id)
    CartItem.create(
      name: @food.name,
      measurement_unit: @food.measurement_unit,
      price: @food.price,
      quantity: @recipe_food.quantity,
      recipe: @recipe,
      user: @user
    )
    login_as(@user, scope: :user)
  end

  describe 'index page' do
    before { visit shopping_list_path }

    it 'displays the title "Shopping List"' do
      expect(page).to have_content('Shopping List')
    end

    it 'displays a table with the Shopping List' do
      expect(page).to have_selector('table')
    end
  end
end
