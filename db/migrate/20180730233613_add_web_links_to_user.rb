class AddWebLinksToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :web_links, :user
  end
end
