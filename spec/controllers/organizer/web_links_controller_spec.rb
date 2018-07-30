require "rails_helper"

describe Organizer::WebLinksController do
  it_behaves_like "authenticated_organizer_page", actions: [:index]

  describe "#index", :authenticated_user do
    it "renders" do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
