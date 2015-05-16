class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.references :poll, index: true
      t.string :title
      t.references :poll, index: true

      t.timestamps
    end
  end
end
