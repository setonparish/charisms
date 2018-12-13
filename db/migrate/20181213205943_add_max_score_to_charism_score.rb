class AddMaxScoreToCharismScore < ActiveRecord::Migration[5.2]
  def change
    add_column :charism_scores, :max_score, :integer, default: 0
  end
end
