Rails.application.routes.draw do
  devise_for :users
  root 'public_recipes#index'

  resources :foods
  
  resources :recipes, except: [:update], as: 'recipes' do
    member do
      patch 'toggle'
      post 'add_ingredient'
      delete 'remove_ingredient/:food_id', action: :remove_ingredient, as: 'remove_ingredient'
      get 'edit_ingredient/:food_id', to: 'recipe_foods#edit_ingredient', as: 'edit_ingredient'
      patch 'update_ingredient/:food_id', to: 'recipe_foods#update_ingredient', as: 'update_ingredient'
    end
  end

  get '/public_recipes', to: 'public_recipes#index', as: 'public_recipes'
  get '/general_shopping_list', to: 'shopping_list#index', as: 'shopping_list'
  post '/general_shopping_list', to: 'shopping_list#generate', as: 'generate_shopping_list'
  get '/recipes/:id/details', to: 'recipes#details', as: 'recipe_details'
  patch 'recipes/:id/details', to: 'recipes#update_details', as: 'update_details'

end
