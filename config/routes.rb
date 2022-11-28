Rails.application.routes.draw do
  devise_for :users
  # root 'homes#index'
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
