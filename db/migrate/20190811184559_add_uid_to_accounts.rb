class AddUidToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :uid, :string
  end
end
