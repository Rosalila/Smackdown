class AddImagePathToGame < ActiveRecord::Migration
  def change
    add_column :games, :image_path, :string
  end
end
