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
      let!(:survey) { FactoryBot.create(:survey, name: Survey::DEFAULT_NAME) }

      it "returns the survey" do
        expect(Survey.default).to eq(survey)
      end
    end

    context "when default survey does exists" do
      it "default survey does not exist" do
        expect(Survey.default).to eq(nil)
      end
    end
  end
end
