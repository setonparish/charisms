require "rails_helper"

describe Organizer::OpportunitiesController do
  it_behaves_like "authenticated_organizer_page", actions: [:index, :new, :create, :edit, :update]

  let!(:opportunity) { FactoryBot.create(:opportunity, organization: organization) }
  let(:organization) { FactoryBot.create(:organization, users: [user]) }
  let(:user) { FactoryBot.create(:user) }

  before do
    allow_any_instance_of(described_class).to receive(:current_user).and_return(user)
    allow_any_instance_of(described_class).to receive(:current_organization).and_return(organization)
  end

  describe "#index" do
    it "renders" do
      get :index
      expect(assigns(:opportunities)).to contain_exactly(opportunity)
      expect(response).to render_template(:index)
    end
  end

  describe "#new" do
    it "renders" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    it "creates Opportunity" do
      expect {
        post :create, params: { opportunity: { name: "Opportunity Name" } }
      }.to change {
        organization.reload.opportunities.count
      }.by(1)
    end
  end

  describe "#edit" do
    it "renders" do
      get :edit, params: { id: opportunity.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do
    before do
      opportunity.charisms << FactoryBot.create(:charism)
    end

    it "updates attributes" do
      expect {
        post :update, params: { id: opportunity.id, opportunity: { name: "Updated Name", description: "Updated Description" } }
      }.to change {
        opportunity.reload.name
      }.to("Updated Name").and change {
        opportunity.description
      }.to("Updated Description").and change {
        opportunity.charisms
      }.to([])
    end
  end
end
