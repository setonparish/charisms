require 'rails_helper'

describe Survey do
  describe "validations" do
    let(:user) { FactoryBot.build(:user) }

    it "is a valid factory" do
      expect(user).to be_valid
    end
  end

  describe ".authenticate" do
    let!(:user) { FactoryBot.create(:user, email: "UPPERCASE@example.com", password: "password") }

    it "returns user record for correct password" do
      expect(User.authenticate("UPPERCASE@example.com", "password")).to eq(user)
    end

    it "returns false for incorrect password" do
      expect(User.authenticate("UPPERCASE@example.com", "not-correct-password")).to eq(false)
    end
  end
end
