class CreateMetaImages < ActiveRecord::Migration
  def change
    create_table :meta_images do |t|
      t.string :path

      t.timestamps
    end
  end
end
