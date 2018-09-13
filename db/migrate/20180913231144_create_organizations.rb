class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :name

      t.timestamps
    end

    add_reference :organization_memberships, :organization, foreign_key: true
  end
end
