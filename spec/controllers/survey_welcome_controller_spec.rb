require "rails_helper"

describe SurveyWelcomeController do
  context "with a custom link containing a web link slug" do
    let(:web_link) { FactoryBot.create(:web_link) }

    describe "#new" do
      let(:call) { get :new, params: { web_link_slug: web_link.slug } }

      it "sets the web_link slug" do
        expect {
          call
        }.to change {
          session[:web_link_id]
        }.from(nil).to(web_link.id)
      end

      it "renders" do
        call
        expect(response).to render_template(:new)
      end
    end
  end

  context "with no custom link containing a web link slug" do
    describe "#new" do
      let!(:default_catch_all_web_link) { FactoryBot.create(:web_link, :default) }
      let(:call) { get :new }

      it "sets the default web_link slug" do
        expect {
          call
        }.to change {
          session[:web_link_id]
        }.from(nil).to(WebLink.default.id)
      end

      it "renders" do
        call
        expect(response).to render_template(:new)
      end
    end
  end
end
