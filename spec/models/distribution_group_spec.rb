require "rails_helper"

describe DistributionGroup do
  describe "validations" do
    let(:distribution_group) { FactoryBot.build(:distribution_group) }

    it "is a valid factory" do
      expect(distribution_group).to be_valid
    end
  end
end