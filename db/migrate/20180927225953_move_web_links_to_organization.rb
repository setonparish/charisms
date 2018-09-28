class MoveWebLinksToOrganization < ActiveRecord::Migration[5.2]
  def change
    remove_reference :web_links, :user
    add_reference :web_links, :organization
  end
end
