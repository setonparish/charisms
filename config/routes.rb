Rails.application.routes.draw do
  resources :welcome, only: :index
  resources :respondents, only: [:new, :create]
  root "welcome#index"
end
