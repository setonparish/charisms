require "rails_helper"

describe Question do
  describe "validations" do
    let(:question) { FactoryBot.build(:question) }

    it "is a valid factory" do
      expect(question).to be_valid
    end
  end
end
