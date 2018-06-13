require "rails_helper"

describe CharismScoreCreator do
  let(:survey_response) { FactoryBot.create(:survey_response) }
  let(:charism_one) { FactoryBot.create(:charism) }
  let(:charism_two) { FactoryBot.create(:charism) }
  let(:service) { CharismScoreCreator.new(survey_response: survey_response) }

  describe "#run" do
    before do
      FactoryBot.create(:question_response, survey_response: survey_response, answer: nil, charism: charism_one)
      FactoryBot.create(:question_response, survey_response: survey_response, answer: 1, charism: charism_one)
      FactoryBot.create(:question_response, survey_response: survey_response, answer: 2, charism: charism_one)

      FactoryBot.create(:question_response, survey_response: survey_response, answer: 2, charism: charism_two)
    end

    it "creates an aggregate score for each charism" do
      scores = service.run

      aggregate_failures do
        expect(scores.size).to eq(2)
        expect(scores.first.score).to eq(3)
        expect(scores.first.charism).to eq(charism_one)
        expect(scores.second.score).to eq(2)
        expect(scores.second.charism).to eq(charism_two)
      end
    end
  end
end
