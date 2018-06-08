require "rails_helper"

describe Charism do
  describe "validations" do
    let(:charism) { FactoryBot.build(:charism) }

    it "is a valid factory" do
      expect(charism).to be_valid
    end
  end
end

