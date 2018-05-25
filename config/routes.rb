Rails.application.routes.draw do
  resources :welcome, only: :index
  resources :respondents, only: [:new, :create]
  resources :survey_responses, only: [:new, :create]

  root "welcome#index"
end
