class CreateSurveyResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :survey_responses do |t|
      t.string :slug, index: true
      t.references :survey, foreign_key: true
      t.references :respondent, foreign_key: true

      t.timestamps
    end
  end
end
