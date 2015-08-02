class Dojo < ActiveRecord::Base
  mount_uploader :main_image, FileUploader
  mount_uploader :badge_image, FileUploader
  has_many :users, through: :user_in_dojos
  has_many :user_in_dojos
  has_many :dojo_invitations
  def userIsAdmin user
    user_in_dojo = UserInDojo.where(user: user, dojo_id: id)[0]
    if user_in_dojo == nil
      return false
    end
    return user_in_dojo.is_admin
  end
end
