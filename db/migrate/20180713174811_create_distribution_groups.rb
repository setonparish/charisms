class CreateDistributionGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :distribution_groups do |t|
      t.string :name
      t.references :survey, foreign_key: true
      t.string :slug

      t.timestamps
    end
  end
end
