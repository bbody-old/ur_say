class AddNewFiledsToSurveyTakers < ActiveRecord::Migration
  def change
    add_column :survey_takers, :message_id, :string
    add_column :survey_takers, :confirmed, :integer
  end
end
