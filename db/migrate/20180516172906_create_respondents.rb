class CreateRespondents < ActiveRecord::Migration[5.2]
  def change
    create_table :respondents do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :site_admin, default: false, null: false

      t.timestamps
    end
  end
end
