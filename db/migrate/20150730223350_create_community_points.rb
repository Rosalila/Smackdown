class CreateCommunityPoints < ActiveRecord::Migration
  def change
    create_table :community_points do |t|
      t.integer :community_id
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
