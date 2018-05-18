class CreateQuestionResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :question_responses do |t|
      t.references :survey_response, foreign_key: true
      t.references :question, foreign_key: true
      t.string :answer

      t.timestamps
    end
  end
end
