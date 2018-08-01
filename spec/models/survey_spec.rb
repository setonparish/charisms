require 'rails_helper'

describe Survey do
  describe "validations" do
    let(:survey) { FactoryBot.build(:survey) }

    it "is a valid factory" do
      expect(survey).to be_valid
    end
  end

  describe ".default" do
    context "default survey exists" do
      it "returns the survey" do
        expect(Survey.default).to eq(Survey.find_by(name: Survey::DEFAULT_NAME))
      end
    end
  end
end
