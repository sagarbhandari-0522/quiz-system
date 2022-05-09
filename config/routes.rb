# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy', as: :logout
  end
  resources :notifications, only: [:index]
  resources :dashboards
  resources :questions do
    resources :options
  end
  resources :categories
  resources :quizzes
  root 'welcome#index'
  get '/play_quiz', to: 'quizzes#select_category', as: :play_quiz
end
