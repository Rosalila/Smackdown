class CreatePlayerStyles < ActiveRecord::Migration
  def change
    create_table :player_styles do |t|
      t.string :name
      t.string :image
      t.text :description
      t.string :long_description_link

      t.timestamps
    end
  end
end
