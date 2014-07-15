class CreateSmackdowns < ActiveRecord::Migration
  def change
    create_table :smackdowns do |t|
      t.integer :player1_id
      t.integer :player2_id
      t.integer :judge1_id
      t.integer :judge2_id
      t.integer :judge1_winner_id
      t.integer :judge2_winner_id
      t.boolean :player2_accepted
      t.boolean :judge1_accepted
      t.boolean :judge2_accepted
      t.text :judge1_comment
      t.text :judge2_comment

      t.timestamps
    end
  end
end
