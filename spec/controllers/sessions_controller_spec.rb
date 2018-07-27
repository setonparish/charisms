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

      it "redirects to root page" do
        call
        expect(response).to redirect_to(root_path)
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
