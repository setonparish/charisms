require "rails_helper"

describe Organizer::ReportsController do
  it_behaves_like "authenticated_organizer_page", actions: [:index]

  let(:organization) { FactoryBot.create(:organization) }
  let(:user) { FactoryBot.create(:user) }

  before do
    allow_any_instance_of(described_class).to receive(:current_user).and_return(user)
    allow_any_instance_of(described_class).to receive(:current_organization).and_return(organization)
  end

  describe "#index" do
    it "renders" do
      get :index
      expect(response).to render_template(:index)
    end
  end
end