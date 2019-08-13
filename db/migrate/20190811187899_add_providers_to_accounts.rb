class AddProvidersToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :provider, :string
  end
end
