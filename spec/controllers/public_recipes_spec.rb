require 'rails_helper'

RSpec.describe PublicRecipesController, type: :controller do
  describe 'GET #index' do
    it 'eager loads associated user and foods' do
      public_recipe = Recipe.create(name: 'Public Recipe', public: true)
      user = User.create(name: 'Test user', email: 'test444@gmail.com',
                         password: '123456', password_confirmation: '123456')
      food = Food.create(name: 'Test food', price: 12.2, quantity: 4, measurement_unit: 'pce', user:)
      public_recipe.foods << food

      expect(Recipe).to receive(:includes).with(:user, :foods).and_call_original

      get :index
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end
end
