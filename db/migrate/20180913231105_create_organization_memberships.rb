class CreateOrganizationMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :organization_memberships do |t|
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
