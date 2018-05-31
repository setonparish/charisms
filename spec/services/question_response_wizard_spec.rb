require "rails_helper"

describe QuestionResponseWizard do
  let(:survey_response) { FactoryBot.create(:survey_response) }
  let!(:question_responses) { FactoryBot.create_list(:question_response, 3, survey_response: survey_response, answer: nil) }

  context "without a specific question_response" do
    let(:service) do
      QuestionResponseWizard.new(survey_response: survey_response)
    end

    describe "#current" do
      context "with all unanswered questions" do
        it "returns first question_response" do
          expect(service.current).to eq(question_responses.first)
        end
      end

      context "with one unanswered question" do
        before do
          question_responses.first.update(answer: "canticle of the sun")
        end

        it "returns second question_response" do
          expect(service.current).to eq(question_responses.second)
        end
      end
    end

    describe "#next" do
      it "returns next question_response" do
        expect(service.next).to eq(question_responses.second)
      end
    end

    describe "#previous" do
      it "returns nil" do
        expect(service.previous).to be_nil
      end
    end

    describe "#can_show_next?" do
      context "if current question is answered and there is a next question" do
        it "returns true" do
          service.current.answer = "cantical of the sun"
          expect(service.can_show_next?).to eq(true)
        end
      end
    end
  end


  context "with a specific question_response" do
    let(:service) do
      QuestionResponseWizard.new(survey_response: survey_response, question_response: question_responses.second)
    end

    describe "#current" do
      it "returns the specific question_response" do
        expect(service.current).to eq(question_responses.second)
      end
    end

    describe "#next" do
      it "returns next question_response" do
        expect(service.next).to eq(question_responses.third)
      end
    end

    describe "#previous" do
      it "returns nil" do
        expect(service.previous).to eq(question_responses.first)
      end
    end

    describe "#can_show_next?" do
      context "if current question is answered and there is a next question" do
        it "returns true" do
          service.current.answer = "cantical of the sun"
          expect(service.can_show_next?).to eq(true)
        end
      end
    end
  end
end
