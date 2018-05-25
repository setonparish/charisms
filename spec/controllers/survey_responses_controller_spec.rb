require "rails_helper"

describe SurveyResponsesController do

  shared_examples "redirects without a respondent" do
    before do
      session[:respondent_id] = nil
    end

    it "redirects to respondents#new" do
      call
      expect(subject).to redirect_to(new_respondent_path)
    end
  end

  describe "#new" do
    let(:call) { get :new }

    it_behaves_like "redirects without a respondent"

    before do
      respondent = FactoryBot.create(:respondent)
      session[:respondent_id] = respondent.id
    end

    it "renders" do
      call
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    let(:call) { post :create }

    let(:survey) { FactoryBot.create(:survey) }
    let(:respondent) { FactoryBot.create(:respondent) }

    it_behaves_like "redirects without a respondent"

    before do
      session[:respondent_id] = respondent.id
    end

    it "calls service" do
      mock_service = double(:run)
      expect(SurveyResponseCreator).to receive(:new).with(survey: survey, respondent: respondent) { mock_service }
      expect(mock_service).to receive(:run)
      call
    end
  end
end
