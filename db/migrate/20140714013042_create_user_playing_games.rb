class CreateUserPlayingGames < ActiveRecord::Migration
  def change
    create_table :user_playing_games do |t|
      t.integer :user_id
      t.integer :game_id
      t.boolean :is_playing

      t.timestamps
    end
  end
end
