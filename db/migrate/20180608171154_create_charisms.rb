class CreateCharisms < ActiveRecord::Migration[5.2]
  def change
    create_table :charisms do |t|
      t.string :name

      t.timestamps
    end

    add_reference :questions, :charism, index: true
  end
end
