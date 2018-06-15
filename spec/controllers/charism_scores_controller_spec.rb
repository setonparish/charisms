require "rails_helper"

describe CharismScoresController do

  let(:survey_response) { FactoryBot.create(:survey_response) }
  let!(:charism_scores) { FactoryBot.create_list(:charism_score, 3, survey_response: survey_response) }

  describe "#show" do
    let(:call) { get :show, params: { survey_response_id: survey_response } }

    it "renders" do
      call
      expect(response).to render_template(:show)
    end
  end
end
