class AddSteamidToUser < ActiveRecord::Migration
  def change
    add_column :users, :steamid, :string
  end
end
