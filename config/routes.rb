Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  resources :exercises, only:[:new, :create, :show, :index]
  resources :diaries, only: [:index, :show, :new, :create, :edit, :update]
  resources :users, only: [:show]
  resources :schedules, only: [:new, :create, :index, :edit, :update]
  resources :counts, only: [:create, :update]
  root "exercises#index"
end
