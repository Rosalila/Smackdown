class CreateUserInDojos < ActiveRecord::Migration
  def change
    create_table :user_in_dojos do |t|
      t.integer :user_id
      t.integer :dojo_id
      t.boolean :is_admin

      t.timestamps
    end
  end
end
