Rails.application.routes.draw do
  # root 'homes#index'
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end
