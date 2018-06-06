require "rails_helper"

describe QuestionResponsesController do

  let(:question_response) { FactoryBot.create(:question_response) }
  let(:survey_response) { question_response.survey_response }

  describe "#edit" do
    let(:call) { get :edit, params: { survey_response_id: survey_response.id, question_response_position: question_response.position} }

    it "renders" do
      call
      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do
    let(:call) { post :update, params: { question_response: { answer: "canticle of the sun" }, survey_response_id: survey_response.id, question_response_position: question_response.position } }

    context "answered a previously answered question on the survey" do
      let!(:next_question_response) do
        FactoryBot.create(:question_response, survey_response: survey_response, answer: nil)
      end

      let!(:last_question_response) do
        FactoryBot.create(:question_response, survey_response: survey_response, answer: nil)
      end

      before do
        question_response.update(answer: "saint francis")
        last_question_response.update(answer: "saint francis")
      end

      it "renders" do
        call
        expect(response).to redirect_to answer_survey_question_path(survey_response, next_question_response.position)
      end
    end

    context "only unanswered questions are left to answer on survey" do
      let!(:next_question_response) do
        FactoryBot.create(:question_response, survey_response: survey_response, answer: nil)
      end

      it "renders" do
        call
        expect(response).to redirect_to answer_survey_path(survey_response)
      end
    end

    context "no unanswered questions are left to answer on survey" do
      # TODO: temporary until scoring page is complete
      it "redirects to the root path" do
        call
        expect(response).to redirect_to root_path
      end
    end
  end
end
