Rails.application.routes.draw do
  devise_for :users
  root 'public_recipes#index'

  resources :foods, only: [:index]
  
  resources :recipes, except: [:edit, :update] do
    member do
      patch 'toggle'
    end
  end

  get '/public_recipes', to: 'public_recipes#index', as: 'public_recipes'
  get '/general_shopping_list', to: 'shopping_list#index', as: 'shopping_list'
  get '/recipes/:id/details', to: 'recipes#details', as: 'recipe_details'

end
