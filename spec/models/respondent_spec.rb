require "rails_helper"

describe Respondent do
  describe "validations" do
    let(:respondent) { FactoryBot.build(:respondent) }

    it "is a valid factory" do
      expect(respondent).to be_valid
    end

    it "does not require an email address" do
      respondent.email = nil
      expect(respondent).to be_valid
    end
  end

  describe "#name" do
    let(:respondent) { FactoryBot.build(:respondent, first_name: "Saint", last_name: "Anthony") }

    it "builds a name" do
      expect(respondent.name).to eq("Saint Anthony")
    end
  end
end

