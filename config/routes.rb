# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get 'weather/index'
  get '/weather' => 'weather#index'
  get 'newsarticles/top_news'
  get 'newsarticles/all_news'

  resources :newsarticles
  post '/newsarticles/save', to: 'newsarticles#save'

  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
