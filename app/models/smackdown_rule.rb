class SmackdownRule < ActiveRecord::Base
  belongs_to :smackdown
  belongs_to :rule
end
