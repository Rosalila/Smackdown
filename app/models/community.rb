class Community < ActiveRecord::Base
  has_many :community_points
  has_many :users, through: :user_in_community
  has_many :user_in_community
end
