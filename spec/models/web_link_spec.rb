require "rails_helper"

describe WebLink do
  describe "validations" do
    let(:web_link) { FactoryBot.build(:web_link) }

    it "is a valid factory" do
      expect(web_link).to be_valid
    end
  end
end