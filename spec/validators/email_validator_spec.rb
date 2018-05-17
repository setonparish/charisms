require "rails_helper"

# Basic test object
module Test
  EmailValidatable = Struct.new(:email) do
    include ActiveModel::Validations

    validates :email, email: true
  end
end

describe EmailValidator do
  let(:model) { Test::EmailValidatable.new(email) }

  context "with an @ sign" do
    let(:email) { "saintanthony@example.com" }

    it "is valid" do
      expect(model).to be_valid
    end
  end

  context "without an @ sign" do
    let(:email) { "saintanthonyexample.com" }

    it "is valid" do
      aggregate_failures do
        expect(model).to be_invalid
        expect(model.errors[:email]).to match_array("is not a valid format")
      end
    end
  end
end
