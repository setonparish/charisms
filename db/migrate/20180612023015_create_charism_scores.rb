class CreateCharismScores < ActiveRecord::Migration[5.2]
  def change
    create_table :charism_scores do |t|
      t.references :survey_response, foreign_key: true
      t.references :charism, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
