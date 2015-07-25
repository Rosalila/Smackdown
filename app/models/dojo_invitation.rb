class DojoInvitation < ActiveRecord::Base
  belongs_to :dojo
  belongs_to :user
end
