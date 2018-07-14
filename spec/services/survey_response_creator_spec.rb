require "rails_helper"

describe SurveyResponseCreator do

  let(:distribution_group) { FactoryBot.create(:distribution_group) }
  let(:survey) { distribution_group.survey }
  let!(:question_orders) { FactoryBot.create_list(:question_order, 2, survey: survey) }

  let(:respondent) { FactoryBot.create(:respondent) }
  let(:service) do
    SurveyResponseCreator.new(respondent: respondent, survey: survey, distribution_group: distribution_group)
  end

  describe "#run" do
    it "creates one survey_response" do
      expect {
        service.run
      }.to change {
        SurveyResponse.count
      }.by(1)
    end

    it "creates two question_responses" do
      expect {
        service.run
      }.to change {
        QuestionResponse.count
      }.by(2)
    end

    it "sets the correct attributes on the survey_response" do
      survey_response = service.run

      aggregate_failures do
        expect(survey_response.respondent).to eq(respondent)
        expect(survey_response.survey).to eq(survey)
        expect(survey_response.question_responses.size).to eq(2)

        expect(survey_response.question_responses[0].question).to eq(question_orders[0].question)
        expect(survey_response.question_responses[0].position).to eq(question_orders[0].position)
        expect(survey_response.question_responses[0].answer).to be_nil

        expect(survey_response.question_responses[1].question).to eq(question_orders[1].question)
        expect(survey_response.question_responses[1].position).to eq(question_orders[1].position)
        expect(survey_response.question_responses[1].answer).to be_nil
      end
    end
  end

end
