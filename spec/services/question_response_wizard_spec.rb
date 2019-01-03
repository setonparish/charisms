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
          question_responses.first.update(answer: "2")
        end

        it "returns second question_response" do
          expect(service.current).to eq(question_responses.second)
        end
      end

      context "with all answered questions" do
        before do
          question_responses.each { |qr| qr.update(answer: "2") }
        end

        it "returns the last question_response" do
          expect(service.current).to eq(question_responses.last)
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

    describe "#can_manually_proceed?" do
      context "if current question is answered and there is a next question" do
        it "returns true" do
          allow(service.current).to receive(:answered?).and_return(true)
          expect(service.can_manually_proceed?).to eq(true)
        end
      end
    end

    describe "#only_unanswered_questions_remaining" do
      context "with all remaining questions answered" do
        before do
          survey_response.question_responses.update_all(answer: nil)
          survey_response.question_responses.first.update_column(:answer, "2")
        end

        it "returns true" do
          expect(service.only_unanswered_questions_remaining?).to eq(true)
        end
      end

      context "with some remaining questions unanswered" do
        before do
          survey_response.question_responses.update_all(answer: nil)
          survey_response.question_responses.last.update_column(:answer, "2")
        end

        it "returns false" do
          expect(service.only_unanswered_questions_remaining?).to eq(false)
        end
      end
    end

    describe "#survey_completed?" do
      context "with all questions answered" do
        before do
          survey_response.question_responses.update_all(answer: "simon peter")
        end

        it "returns true" do
          expect(service.survey_completed?).to eq(true)
        end
      end

      context "with one question unanswered" do
        before do
          survey_response.question_responses.update_all(answer: "simon peter")
          survey_response.question_responses.last.update_column(:answer, nil)
        end

        it "returns false" do
          expect(service.survey_completed?).to eq(false)
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

    describe "#can_manually_proceed?" do
      context "if current question is answered and there is a next question" do
        it "returns true" do
          service.current.answer = "cantical of the sun"
          expect(service.can_manually_proceed?).to eq(true)
        end
      end
    end

    describe "#only_unanswered_questions_remaining" do
      context "with all remaining questions answered" do
        before do
          survey_response.question_responses.update_all(answer: nil)
          survey_response.question_responses.first.update_column(:answer, "2")
        end

        it "returns true" do
          expect(service.only_unanswered_questions_remaining?).to eq(true)
        end
      end

      context "with some remaining questions unanswered" do
        before do
          survey_response.question_responses.update_all(answer: nil)
          survey_response.question_responses.last.update_column(:answer, "2")
        end

        it "returns false" do
          expect(service.only_unanswered_questions_remaining?).to eq(false)
        end
      end
    end

    describe "#survey_completed?" do
      context "with all questions answered" do
        before do
          survey_response.question_responses.update_all(answer: "2")
        end

        it "returns true" do
          expect(service.survey_completed?).to eq(true)
        end
      end

      context "with one question unanswered" do
        before do
          survey_response.question_responses.update_all(answer: "2")
          survey_response.question_responses.last.update_column(:answer, nil)
        end

        it "returns false" do
          expect(service.survey_completed?).to eq(false)
        end
      end
    end
  end
end
