Rails.application.routes.draw do
  # root 'homes#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    password: 'users/password'
  }
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
    post 'users/guest_admin_sign_in', to: 'users/sessions#guest_admin_sign_in'
  end

  resources :profiles, only: [:edit, :update, :show, :index]
  resources :blogs do
    resources :comments
    resource :favorites, only:[:create, :destroy]
    collection do
      get :yourself_blog
    end
  end
  resources :favorites, only:[:index]
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
