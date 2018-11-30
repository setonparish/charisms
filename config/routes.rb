Rails.application.routes.draw do

  get  "login"  => "sessions#new"
  post "login"  => "sessions#create"

  resources :welcome, only: :index
  resources :respondents, only: [:new, :create]

  namespace :organizer do
    resources :opportunities
    resources :reports, only: [:index]
    resources :web_links, except: [:show, :destroy]

    root "web_links#index", as: :dashboard
  end

  #
  # Expose prettier routes to the end user for answering survey questions
  #
  scope :responses do
    # start a survey - /responses/survey/begin
    get "survey/begin/(:web_link_slug)", to: "survey_welcome#new", as: :begin_survey

    # answer the most recent survey question - /responses/survey/vl5if6sphzex
    get "survey/:survey_response_id", to: "question_responses#edit", as: :answer_survey

    # answer a specific survey question - /responses/survey/vl5if6sphzex/questions/2
    get "survey/:survey_response_id/questions/:question_response_position", to: "question_responses#edit", as: :answer_survey_question
    post "survey/:survey_response_id/questions/:question_response_position", to: "question_responses#update"

    # show final score - /responses/survey/vl5if6sphzex/result
    get "survey/:survey_response_id/result", to: "charism_scores#show", as: :survey_result
  end

  root "welcome#index"
end
