require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :controller do
  describe 'GET #edit_ingredient' do
    let(:user) do
      User.create(name: 'Nick', email: 'nick@example.com', password: '123456', password_confirmation: '123456')
    end
    let!(:recipe) do
      Recipe.create(name: 'Test', preparation_time: '1 hr', cooking_time: '1 hr', description: 'Test', public: true,
                    user_id: user.id)
    end
    let!(:food) { Food.create(name: 'Apple', user_id: user.id, measurement_unit: 'grams', price: 100, quantity: 1) }
    let!(:recipe_food) { RecipeFood.create(quantity: 1, recipe_id: recipe.id, food_id: food.id) }

    it 'returns a success response' do
      get :edit_ingredient, params: { id: recipe.id, food_id: food.id }
      expect(response).to be_successful
    end

    it 'assigns the correct recipe' do
      get :edit_ingredient, params: { id: recipe.id, food_id: food.id }
      expect(assigns(:recipe)).to eq(recipe)
    end

    it 'assigns the correct food' do
      get :edit_ingredient, params: { id: recipe.id, food_id: food.id }
      expect(assigns(:food)).to eq(food)
    end

    it 'assigns the correct recipe food' do
      get :edit_ingredient, params: { id: recipe.id, food_id: food.id }
      expect(assigns(:recipe_food)).to eq(recipe_food)
    end
  end

  describe 'PATCH #update_ingredient' do
    let(:user) do
      User.create(name: 'Nick', email: 'nick@example.com', password: '123456', password_confirmation: '123456')
    end
    let!(:recipe) do
      Recipe.create(name: 'Test', preparation_time: '1 hr', cooking_time: '1 hr', description: 'Test', public: true,
                    user_id: user.id)
    end
    let!(:food) { Food.create(name: 'Apple', user_id: user.id, measurement_unit: 'grams', price: 100, quantity: 1) }
    let!(:recipe_food) { RecipeFood.create(quantity: 1, recipe_id: recipe.id, food_id: food.id) }

    context 'with valid parameters' do
      it 'updates the ingredient quantity' do
        new_quantity = 2
        patch :update_ingredient, params: { id: recipe.id, food_id: food.id, recipe_food: { quantity: new_quantity } }
        recipe_food.reload
        expect(recipe_food.quantity).to eq(new_quantity)
      end

      it 'redirects to the recipe' do
        patch :update_ingredient, params: { id: recipe.id, food_id: food.id, recipe_food: { quantity: 2 } }
        expect(response).to redirect_to(recipe)
      end

      it 'sets a success notice' do
        patch :update_ingredient, params: { id: recipe.id, food_id: food.id, recipe_food: { quantity: 2 } }
        expect(flash[:notice]).to be_present
      end
    end
  end
end
