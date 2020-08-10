Rails.application.routes.draw do
  get 'diaries/index'
  get 'diaries/show'
  devise_for :users
  resources :exercises
  root "exercises#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
