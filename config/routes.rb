# frozen_string_literal: true

Rails.application.routes.draw do
  get 'dashboards/index'
  devise_for :users
  resources :dashboards
  resources :question
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'welcome#index'
end
