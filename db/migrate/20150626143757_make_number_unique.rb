class MakeNumberUnique < ActiveRecord::Migration
  def change
  	add_index :survey_takers, :number, unique: true
  end
end
