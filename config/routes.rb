Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get "/api/v1/merchants/find", to: 'merchants/search#show'

  namespace :api do
    namespace :v1 do
      get "merchants/find", to: 'merchants/search#show'
      get "items/find_all", to: 'items/search#index'
      resources :items, only: [:index, :create, :destroy, :update, :show] do
        resources :merchant, only: [:index], controller: 'items/merchant'
      end
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: 'merchants/items'
      end
    end
  end
end
