class Dojo < ActiveRecord::Base
  mount_uploader :main_image, FileUploader
  mount_uploader :badge_image, FileUploader
  has_many :users, through: :user_in_dojos
  has_many :user_in_dojos
end
