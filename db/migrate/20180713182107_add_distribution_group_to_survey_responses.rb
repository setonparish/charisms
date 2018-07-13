class AddDistributionGroupToSurveyResponses < ActiveRecord::Migration[5.2]
  def change
    add_reference :survey_responses, :distribution_group, foreign_key: true
  end
end
