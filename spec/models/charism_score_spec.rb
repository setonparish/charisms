require "rails_helper"

describe CharismScore do
  describe "validations" do
    let(:charism_score) { FactoryBot.build(:charism_score) }

    it "is a valid factory" do
      expect(charism_score).to be_valid
    end
  end
end
