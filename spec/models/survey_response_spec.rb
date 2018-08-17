require "rails_helper"

describe SurveyResponse do
  describe "validations" do
    let(:survey_response) { FactoryBot.build(:survey_response) }

    it "is a valid factory" do
      expect(survey_response).to be_valid
    end
  end

  describe ".completed" do
    let(:survey_response) { FactoryBot.create(:survey_response) }

    context "when scores have been generated" do
      before do
        FactoryBot.create(:charism_score, survey_response: survey_response)
      end

      it "is included" do
        expect(SurveyResponse.completed).to include(survey_response)
      end
    end

    context "when scores have not been generated" do
      it "is not included" do
        expect(SurveyResponse.completed).to_not include(survey_response)
      end
    end
  end

  describe "slug" do
    let(:survey_response) { FactoryBot.build(:survey_response, slug: nil) }

    it "creates a slug when created" do
      survey_response.save!
      expect(survey_response.slug).to_not be_nil
    end
  end

  describe "completed?" do
    let(:survey_response) { FactoryBot.create(:survey_response) }

    context "when scores have been generated" do
      before do
        FactoryBot.create(:charism_score, survey_response: survey_response)
      end

      it "is true" do
        expect(survey_response.completed?).to eq(true)
      end
    end

    context "when scores have not been generated" do
      it "is false" do
        expect(survey_response.completed?).to eq(false)
      end
    end
  end
end
