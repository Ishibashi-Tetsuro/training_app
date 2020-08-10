Rails.application.routes.draw do
  get 'diaries/index'
  get 'diaries/show'
  devise_for :users
  resources :exercises
  resources :diaries
  root "exercises#index"
end
