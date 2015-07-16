class CreateDojos < ActiveRecord::Migration
  def change
    create_table :dojos do |t|
      t.string :name
      t.string :main_image
      t.string :badge_image
      t.text :about
      t.string :motto
      t.text :schedule
      t.text :public_address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
