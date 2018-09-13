require "rails_helper"

describe Organization do
  describe "validations" do
    let(:organization) { FactoryBot.build(:organization) }

    it "is a valid factory" do
      expect(organization).to be_valid
    end
  end
end