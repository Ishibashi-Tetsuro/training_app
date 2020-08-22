Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
   }
  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  resources :users, only: [:show]
  resources :diaries, only: [:index, :show, :new, :create, :edit, :update] do
    resources :likes, only: [:create, :destroy]
  end
  resources :exercises, only:[:new, :create, :show, :index]
  resources :schedules, only: [:new, :create, :index, :edit, :update]
  resources :counts, only: [:create, :update, :show]
  root 'exercises#index'
end
