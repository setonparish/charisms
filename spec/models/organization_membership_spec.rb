require "rails_helper"

describe OrganizationMembership do
  describe "validations" do
    let(:organization_membership) { FactoryBot.build(:organization_membership) }

    it "is a valid factory" do
      expect(organization_membership).to be_valid
    end
  end
end
