require "rails_helper"

describe QuestionResponse do
  describe "validations" do
    let(:question_response) { FactoryBot.build(:question_response) }

    it "is a valid factory" do
      expect(question_response).to be_valid
    end
  end
end
