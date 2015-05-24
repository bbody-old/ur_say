class AddVotesToOptions < ActiveRecord::Migration
  def change
    add_column :options, :votes, :integer
  end
end
