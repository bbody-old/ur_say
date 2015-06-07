class CreateSurveyTakers < ActiveRecord::Migration
  def change
    create_table :survey_takers do |t|
      t.string :name
      t.string :number

      t.timestamps
    end
  end
end
