class AddDescriptionToCharisms < ActiveRecord::Migration[5.2]
  def change
    add_column :charisms, :description, :text
  end
end
