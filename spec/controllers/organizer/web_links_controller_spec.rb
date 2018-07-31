require "rails_helper"

describe Organizer::WebLinksController do
  it_behaves_like "authenticated_organizer_page", actions: [:index]

  describe "#index" do
    let!(:web_link) { FactoryBot.create(:web_link) }
    let(:user) { web_link.user }

    before do
      allow_any_instance_of(described_class).to receive(:current_user).and_return(user)
    end

    it "renders" do
      get :index
      expect(assigns(:web_links)).to contain_exactly(web_link)
      expect(response).to render_template(:index)
    end
  end
end
