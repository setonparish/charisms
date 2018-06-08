require "rails_helper"

describe QuestionResponse do
  describe "validations" do
    let(:question_response) { FactoryBot.build(:question_response) }

    it "is a valid factory" do
      expect(question_response).to be_valid
    end
  end

  describe ".unanswered" do
    let!(:answered_question_response) { FactoryBot.create(:question_response, answer: "2") }
    let!(:unanswered_question_response) { FactoryBot.create(:question_response, answer: nil) }

    it "returns answered question_responses" do
      expect(QuestionResponse.answered).to match_array(answered_question_response)
    end
  end

  describe ".answered" do
    let!(:answered_question_response) { FactoryBot.create(:question_response, answer: "2") }
    let!(:unanswered_question_response) { FactoryBot.create(:question_response, answer: nil) }

    it "returns answered question_responses" do
      expect(QuestionResponse.unanswered).to match_array(unanswered_question_response)
    end
  end

  describe "#answered?" do
    let(:question_response) { FactoryBot.build(:question_response, answer: "2") }

    it "is a valid factory" do
      expect(question_response).to be_answered
    end
  end

  describe "#unanswered?" do
    let(:question_response) { FactoryBot.build(:question_response, answer: nil) }

    it "is a valid factory" do
      expect(question_response).to be_unanswered
    end
  end
end
