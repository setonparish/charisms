require "rails_helper"

describe RespondentsController do
  describe "#new" do
    it "renders the index template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "#create" do
    let(:survey) { FactoryBot.create(:survey) }
    let(:distribution_group) { FactoryBot.create(:distribution_group, survey: survey) }

    before do
      session[:distribution_group_id] = distribution_group.id
    end

    context "with valid parameters" do
      let(:mock_service) { double(:run) }
      let(:survey_response) { FactoryBot.create(:survey_response, survey: survey) }
      let(:params) do
        { respondent: { first_name: "Saint", last_name: "Anthony", email: "saintanthony@example.com" } }
      end

      it "creates a new respondent" do
        expect {
          post(:create, params: params)
        }.to change {
          Respondent.count
        }.by(1)
      end

      it "calls service and redirects to survey_responses#edit" do
        expect(SurveyResponseCreator).to receive(:new).with(survey: survey, respondent: instance_of(Respondent), distribution_group: distribution_group) { mock_service }
        expect(mock_service).to receive(:run) { survey_response }
        post(:create, params: params)
        expect(subject).to redirect_to(answer_survey_path(survey_response))
      end
    end

    context "with invalid parameters" do
      let(:params) do
        { respondent: { first_name: nil, last_name: "Anthony", email: "saintanthony@example.com" } }
      end

      it "renders the new template" do
        post(:create, params: params)
        expect(response).to render_template("new")
      end

      it "does not create a new respondent" do
        expect {
          post(:create, params: params)
        }.to_not change {
          Respondent.count
        }
      end
    end
  end
end
