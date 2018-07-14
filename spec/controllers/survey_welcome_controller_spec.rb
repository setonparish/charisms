require "rails_helper"

describe SurveyWelcomeController do
  context "with a custom link containing a distribution group slug" do
    let(:distribution_group) { FactoryBot.create(:distribution_group) }

    describe "#new" do
      let(:call) { get :new, params: { distribution_group_slug: distribution_group.slug } }

      it "sets the distribution_group slug" do
        expect {
          call
        }.to change {
          session[:distribution_group_id]
        }.from(nil).to(distribution_group.id)
      end

      it "renders" do
        call
        expect(response).to render_template(:new)
      end
    end
  end

  context "with no custom link containing a distribution group slug" do
    let!(:distribution_group) { FactoryBot.create(:distribution_group, :default) }

    describe "#new" do
      let(:call) { get :new }

      it "sets the default distribution_group slug" do
        expect {
          call
        }.to change {
          session[:distribution_group_id]
        }.from(nil).to(distribution_group.id)
      end

      it "renders" do
        call
        expect(response).to render_template(:new)
      end
    end
  end
end
