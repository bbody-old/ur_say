class AddEndDateToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :end_date, :date
  end
end
