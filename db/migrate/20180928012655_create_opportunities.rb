class CreateOpportunities < ActiveRecord::Migration[5.2]
  def change
    create_table :opportunities do |t|
      t.string :name
      t.text :description
      t.references :organization

      t.timestamps
    end
  end
end
