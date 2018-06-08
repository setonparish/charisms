class ConvertAnswerColumnToInteger < ActiveRecord::Migration[5.2]
  def change
    remove_column :question_responses, :answer, :string
    add_column :question_responses, :answer, :integer
  end
end
