require "rails_helper"

describe CharismSummary do
  let!(:charism_score_one) { FactoryBot.create(:charism_score) }
  let!(:charism_score_two) { FactoryBot.create(:charism_score) }

  describe "#all" do
    it "returns CharismScoreSummary instances that match initialization filters" do
      service = CharismSummary.new(web_links: charism_score_two.survey_response.web_link)
      aggregate_failures do
        expect(service.all.size).to eq(1)
        expect(service.first).to be_a(CharismScoreSummary)
        expect(service.first.charism).to eq(charism_score_two.charism)
      end
    end
  end
end