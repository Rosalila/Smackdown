class UserInDojo < ActiveRecord::Base
  belongs_to :user
  belongs_to :dojo
end
