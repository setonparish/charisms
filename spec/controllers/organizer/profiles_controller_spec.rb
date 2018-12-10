require "rails_helper"

describe Organizer::ProfilesController do
  it_behaves_like "authenticated_organizer_page", actions: [:edit, :update]

  let!(:user) { FactoryBot.create(:user) }

  before do
    allow_any_instance_of(described_class).to receive(:current_user).and_return(user)
  end

  describe "#edit" do
    it "renders" do
      get :edit, params: { }
      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do
    it "renders" do
      expect {
        post :update, params: { profile: { first_name: "Francis" } }
      }.to change {
        user.reload.first_name
      }.to("Francis")
    end
  end
end
