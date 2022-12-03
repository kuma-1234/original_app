Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    password: 'users/password'
  }
  # root 'homes#index'
  resources :profiles, only: [:edit, :update, :show]
  resources :blogs
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
