class CreateMessageSents < ActiveRecord::Migration
  def change
    create_table :message_sents do |t|
      t.string :message_id
      t.string :result
      t.integer :poll_id

      t.timestamps
    end
  end
end
