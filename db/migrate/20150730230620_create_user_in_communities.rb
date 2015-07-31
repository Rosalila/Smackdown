class CreateUserInCommunities < ActiveRecord::Migration
  def change
    create_table :user_in_communities do |t|
      t.integer :user_id
      t.integer :community_id

      t.timestamps
    end
  end
end
