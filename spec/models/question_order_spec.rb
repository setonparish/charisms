require "rails_helper"

describe QuestionOrder do
  let(:survey) { FactoryBot.build(:survey) }
  let(:question) { FactoryBot.build(:question) }

  describe "validations" do
    let(:question_order) { FactoryBot.build(:question_order, survey: survey, question: question) }

    it "is a valid" do
      expect(question_order).to be_valid
    end
  end

  describe "#position" do
    let(:question_order) { FactoryBot.create(:question_order, survey: survey, question: question) }

    it "automatically defaults" do
      expect(question_order.position).to eq(1)
    end
  end
end
