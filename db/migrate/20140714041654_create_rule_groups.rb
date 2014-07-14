class CreateRuleGroups < ActiveRecord::Migration
  def change
    create_table :rule_groups do |t|
      t.integer :game_id
      t.string :name

      t.timestamps
    end
  end
end
