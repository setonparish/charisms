require 'rails_helper'

describe Survey do
  describe "validations" do
    let(:survey) { FactoryBot.build(:survey) }

    it "is a valid factory" do
      expect(survey).to be_valid
    end
  end
end
