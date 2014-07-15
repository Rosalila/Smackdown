class CreateSmackdownRules < ActiveRecord::Migration
  def change
    create_table :smackdown_rules do |t|
      t.integer :smackdown_id
      t.integer :rule_id

      t.timestamps
    end
  end
end
