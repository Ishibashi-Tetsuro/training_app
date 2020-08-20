Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :diaries, only: [:index, :show, :new, :create, :edit, :update] do
    resources :likes, only: [:create, :destroy]
  end
  resources :exercises, only:[:new, :create, :show, :index]
  resources :schedules, only: [:new, :create, :index, :edit, :update]
  resources :counts, only: [:create, :update, :show]
  root 'exercises#index'
end
