class AddCompanyUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :company_url, :string
  end
end
