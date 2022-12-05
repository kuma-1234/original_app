Rails.application.routes.draw do
  get 'comments/create'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    password: 'users/password'
  }
  # root 'homes#index'
  resources :profiles, only: [:edit, :update, :show]
  resources :blogs do
    resources :comments
  end
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
