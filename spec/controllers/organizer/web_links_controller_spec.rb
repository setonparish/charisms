require "rails_helper"

describe Organizer::WebLinksController do
  it_behaves_like "authenticated_organizer_page", actions: [:index, :new, :create, :edit, :update]

  let!(:web_link) { FactoryBot.create(:web_link, organization: organization) }
  let(:organization) { FactoryBot.create(:organization, users: [user]) }
  let(:user) { FactoryBot.create(:user) }

  before do
    allow_any_instance_of(described_class).to receive(:current_user).and_return(user)
    allow_any_instance_of(described_class).to receive(:current_organization).and_return(organization)
  end

  describe "#index" do
    it "renders" do
      get :index
      expect(assigns(:web_links)).to contain_exactly(web_link)
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
    it "creates WebLink" do
      expect {
        post :create, params: { web_link: { name: "Parish Wide" } }
      }.to change {
        organization.reload.web_links.count
      }.by(1)
    end
  end

  describe "#edit" do
    it "renders" do
      get :edit, params: { id: web_link.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do
    it "renders" do
      expect {
        post :update, params: { id: web_link.id, web_link: { name: "updated name" } }
      }.to change {
        web_link.reload.name
      }.to("updated name")
    end
  end
end
