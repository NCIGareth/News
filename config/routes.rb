Rails.application.routes.draw do
  devise_for :users
  get 'weather/index'
  get 'newsarticles/top_news'
  get 'newsarticles/all_news'

  resources :newsarticles
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
