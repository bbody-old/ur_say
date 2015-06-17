class ChangeResultToInteger < ActiveRecord::Migration
  def change
  	change_column :message_sents, :result, 'integer USING CAST(result AS integer)'
  end
end
