Rails.application.routes.draw do
  root 'exercises#index'
  get 'exercises/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
