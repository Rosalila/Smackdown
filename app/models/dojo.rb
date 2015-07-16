class Dojo < ActiveRecord::Base
  mount_uploader :main_image, FileUploader
  mount_uploader :badge_image, FileUploader
end
