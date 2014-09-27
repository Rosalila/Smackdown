class Smackdown < ActiveRecord::Base
  has_many :smackdown_rules
  def sa
    if judge1_id == judge2_id
      return true
    else 
      return false
    end
  end
end
