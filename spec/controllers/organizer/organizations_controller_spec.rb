require "rails_helper"

describe Organizer::OrganizationsController do
  it_behaves_like "authenticated_organizer_page", actions: [:edit, :update]

  let(:user) { FactoryBot.create(:user) }
  let!(:organization) { FactoryBot.create(:organization, users: [user]) }

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
        post :update, params: { organization: { name: "New Parish Name" } }
      }.to change {
        organization.reload.name
      }.to("New Parish Name")
    end
  end
end
