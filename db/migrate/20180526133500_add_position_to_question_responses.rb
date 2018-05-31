class AddPositionToQuestionResponses < ActiveRecord::Migration[5.2]
  def change
    add_column :question_responses, :position, :integer
  end
end
