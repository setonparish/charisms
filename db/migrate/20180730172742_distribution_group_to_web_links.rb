class DistributionGroupToWebLinks < ActiveRecord::Migration[5.2]
  def change
    rename_table :distribution_groups, :web_links
    rename_column :survey_responses, :distribution_group_id, :web_link_id
  end
end
