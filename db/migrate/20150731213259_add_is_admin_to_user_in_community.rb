class AddIsAdminToUserInCommunity < ActiveRecord::Migration
  def change
    add_column :user_in_communities, :is_admin, :boolean
  end
end
