Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'foods#index'
    resources :foods, only: [:index, :new, :create, :destroy]
    resources :recipes, only: [:index, :new, :create, :destroy, :show, :edit, :update] do
      resources :recipes_foods, only: [:new, :create, :destroy, :edit, :update]
    end
    get '/public_recipes', to: 'recipes#public_recipes'
    get '/general_shopping_list', to: 'recipes#general_shopping_list'

end