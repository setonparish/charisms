require "rails_helper"

describe SessionsController do
  describe "#new" do
    it "renders" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    let!(:user) { FactoryBot.create(:user, email: "padre.pio@example.com", password: "password") }
    let(:call) { post :create, params: { user: { email: user.email, password: password } } }

    context "with correct credentials" do
      let(:password) { "password" }

      it "sets the user session value" do
        expect {
          call
        }.to change {
          session[:user_id]
        }.from(nil).to(user.id)
      end

      it "redirects to root page" do
        call
        expect(response).to redirect_to(organizer_dashboard_path)
      end
    end

    context "with incorrect credentials" do
      let(:password) { "incorrect-password" }

      it "renders new" do
        call
        expect(response).to render_template(:new)
      end
    end
  end
end
