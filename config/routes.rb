Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  resources :exercises
  resources :diaries, only: [:index, :show]
  resources :users, only: [:show]
  resources :schedules, only: [:new]
  root "exercises#index"
end
