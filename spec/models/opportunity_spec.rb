require "rails_helper"

describe Opportunity do
  describe "validations" do
    let(:opportunity) { FactoryBot.build(:opportunity) }

    it "is a valid factory" do
      expect(opportunity).to be_valid
    end
  end
end