Rails.application.routes.draw do
  get 'search/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :products, only: [:index, :show]
  resources :categories, only: [:index, :show]
  resources :users, only: [:index, :show]
  resources :reviews, only: [:index, :show]
  resources :orders, only: [:index, :show]
  resources :order_items, only: [:index, :show]
  resources :contacts, only: [:show]
  resources :abouts, only: [:show]
  resources :search, only: :index
  get 'search', to: 'search#index', as: 'search'
  resources :products do
    collection do
      get :index, defaults: { filter: 'All Products' }
    end
  end

end
