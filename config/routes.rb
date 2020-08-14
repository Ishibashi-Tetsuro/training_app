Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  resources :exercises, only:[:new, :create, :show, :index]
  resources :diaries, only: [:index, :show]
  resources :users, only: [:show]
  resources :schedules, only: [:new, :create, :index]
  root "exercises#index"
end
