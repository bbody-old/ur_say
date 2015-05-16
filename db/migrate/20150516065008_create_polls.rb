class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.references :user, index: true
      t.references :user, index: true
      t.text :question
      t.text :subtext

      t.timestamps
    end
  end
end
