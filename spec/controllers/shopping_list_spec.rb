require 'rails_helper'

RSpec.describe ShoppingListController, type: :controller do
  describe 'GET #index' do
    context 'when user is authenticated' do
      before do
        @user = User.create(name: 'Test user', email: 'test444@gmail.com',
                            password: '123456', password_confirmation: '123456')
        @recipe = Recipe.create(name: 'Test recipe', preparation_time: 10.2, cooking_time: 20.3,
                                description: 'Test description', public: true, user_id: @user.id)
        @food = Food.create(name: 'Test food', price: 12.2, quantity: 4, measurement_unit: 'pce', user_id: @user.id)
        @food_two = Food.create(name: 'Test food Two', price: 12.2, quantity: 4, measurement_unit: 'pce',
                                user_id: @user.id)
        sign_in @user
        get :index
      end

      it 'assigns @foods with user cart items' do
        expect(assigns(:foods)).to eq(CartItem.where(user: @user))
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end
    end

    context 'when user is not authenticated' do
      before { get :index }

      it 'redirects to the sign-in page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
