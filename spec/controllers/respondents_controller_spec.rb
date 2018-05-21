require "rails_helper"

describe RespondentsController do
  describe "#new" do
    it "renders the index template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "#create" do
    context "with valid parameters" do
      let(:params) do
        { respondent: { first_name: "Saint", last_name: "Anthony", email: "saintanthony@example.com" } }
      end

      it "creates a new respondent" do
        expect {
          post(:create, params: params)
        }.to change {
          Respondent.count
        }.by(1)
      end

      it "sets the new respondent in the session" do
        expect(session[:respondent_id]).to be_nil
        post(:create, params: params)
        expect(session[:respondent_id]).to eq(Respondent.last.id)
      end
    end

    context "with invalid parameters" do
      let(:params) do
        { respondent: { first_name: nil, last_name: "Anthony", email: "saintanthony@example.com" } }
      end

      it "renders the new template" do
        post(:create, params: params)
        expect(response).to render_template("new")
      end

      it "does not create a new respondent" do
        expect {
          post(:create, params: params)
        }.to_not change {
          Respondent.count
        }
      end

      it "does not set the session" do
        expect {
          post(:create, params: params)
        }.to_not change {
          session[:respondent_id]
        }
      end
    end
  end
end
