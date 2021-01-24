# frozen_string_literal: true

Rails.application.routes.draw do
  resources :user_stocks, only: %i[create destroy]
  resources :friendships, only: %i[index destroy create]
  resources :users, only: [:show]
  get 'stocks/search'
  devise_for :users
  root 'welcome#index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#search'
  get 'search_friend', to: 'friendships#search'
end
