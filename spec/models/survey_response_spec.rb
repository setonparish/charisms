require "rails_helper"

describe SurveyResponse do
  describe "validations" do
    let(:survey_response) { FactoryBot.build(:survey_response) }

    it "is a valid factory" do
      expect(survey_response).to be_valid
    end
  end

  describe "slug" do
    let(:survey_response) { FactoryBot.build(:survey_response, slug: nil) }

    it "creates a slug when created" do
      survey_response.save!
      expect(survey_response.slug).to_not be_nil
    end
  end
end
