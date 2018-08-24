require "rails_helper"

describe CharismScoreSummary do
  let(:charism) { FactoryBot.create(:charism) }
  let(:charism_score_one) { FactoryBot.create(:charism_score, charism: charism, score: 4) }
  let(:charism_score_two) { FactoryBot.create(:charism_score, charism: charism, score: 6) }

  let(:service) do
    CharismScoreSummary.new(charism: charism, charism_scores: [charism_score_one, charism_score_two])
  end

  describe "#name" do
    it "returns the charism name" do
      expect(service.name).to eq(charism.name)
    end
  end

  describe "#total" do
    it "returns the summation of the scores" do
      expect(service.total).to eq(10)
    end
  end
end