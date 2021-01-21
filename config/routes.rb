# frozen_string_literal: true

Rails.application.routes.draw do
  resources :user_stocks, only: %i[create destroy]
  get 'stocks/search'
  devise_for :users
  root 'welcome#index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#search'
end
