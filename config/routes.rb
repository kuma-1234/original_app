Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    password: 'users/password'
  }
  # root 'homes#index'
  resources :profiles
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
