Rails.application.routes.draw do
  devise_for :users
  root 'public_recipes#index'
  
  get '/foods', to: 'foods#index', as: 'foods'
  get '/recipes', to: 'recipes#index', as: 'recipes'
  get '/recipes/:recipe_id', to: 'recipes#show', as: 'recipe_details'
  get '/public_recipes', to: 'public_recipes#index', as: 'public_recipes'
  get '/general_shopping_list', to: 'shopping_list#index', as: 'shopping_list'

end
