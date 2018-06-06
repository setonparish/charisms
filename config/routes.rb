Rails.application.routes.draw do
  resources :welcome, only: :index
  resources :respondents, only: [:new, :create]

  #
  # Expose prettier routes to the end user for answering survey questions
  #
  scope :responses do
    # start a survey - /responses/survey/begin
    get "survey/begin", to: "survey_responses#new", as: :begin_survey
    post "survey/begin", to: "survey_responses#create"

    # answer the most recent survey question - /responses/survey/vl5if6sphzex
    get "survey/:survey_response_id", to: "question_responses#edit", as: :answer_survey

    # answer a specific survey question - /responses/survey/vl5if6sphzex/questions/2
    get "survey/:survey_response_id/questions/:question_response_position", to: "question_responses#edit", as: :answer_survey_question
    post "survey/:survey_response_id/questions/:question_response_position", to: "question_responses#update"
  end

  root "welcome#index"
end
