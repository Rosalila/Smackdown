class CreatePlayerRules < ActiveRecord::Migration
  def change
    create_table :player_rules do |t|
      t.integer :rule_id
      t.integer :user_id
      t.boolean :activated

      t.timestamps
    end
  end
end
