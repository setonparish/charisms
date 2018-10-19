class CreateCharismOpportunities < ActiveRecord::Migration[5.2]
  def change
    create_table :charism_opportunities do |t|
      t.references :charism, foreign_key: true
      t.references :opportunity, foreign_key: true

      t.timestamps
    end
  end
end
