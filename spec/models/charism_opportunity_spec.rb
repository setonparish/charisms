require "rails_helper"

describe CharismOpportunity do
  describe "validations" do
    let(:charism_opportunity) { FactoryBot.build(:charism_opportunity) }

    it "is a valid factory" do
      expect(charism_opportunity).to be_valid
    end
  end
end

