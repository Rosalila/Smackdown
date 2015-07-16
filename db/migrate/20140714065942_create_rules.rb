class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.integer :rule_group_id
      t.string :name

      t.timestamps
    end
  end
end
