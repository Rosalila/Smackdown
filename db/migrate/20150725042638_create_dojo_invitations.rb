class CreateDojoInvitations < ActiveRecord::Migration
  def change
    create_table :dojo_invitations do |t|
      t.integer :user_id
      t.integer :dojo_id
      t.integer :admin_id

      t.timestamps
    end
  end
end
