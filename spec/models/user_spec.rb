require 'rails_helper'

describe Survey do
  describe "validations" do
    let(:user) { FactoryBot.build(:user) }

    it "is a valid factory" do
      expect(user).to be_valid
    end
  end

  describe "#authenticate" do
    let(:user) { FactoryBot.create(:user, password: "password") }

    it "returns user record for correct password" do
      expect(user.authenticate("password")).to eq(user)
    end

    it "returns false for incorrect password" do
      expect(user.authenticate("not-correct")).to eq(false)
    end
  end
end
