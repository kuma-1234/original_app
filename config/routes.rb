Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'comments/create'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    password: 'users/password'
  }
  # root 'homes#index'
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
