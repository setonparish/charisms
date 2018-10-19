require "rails_helper"

describe Charism do
  describe "validations" do
    let(:charism) { FactoryBot.build(:charism) }

    it "is a valid factory" do
      expect(charism).to be_valid
    end
  end

  describe "#opportunities_for" do
    let!(:charism) { FactoryBot.create(:charism) }
    let!(:opportunity_one) { FactoryBot.create(:opportunity) }
    let!(:opportunity_two) { FactoryBot.create(:opportunity) }

    before do
      charism.opportunities << [opportunity_one, opportunity_two]
    end

    it "returns opportunity for a charism of a specific organization" do
      organization = opportunity_one.organization
      expect(charism.opportunities_for(organization)).to contain_exactly(opportunity_one)
    end
  end
end

