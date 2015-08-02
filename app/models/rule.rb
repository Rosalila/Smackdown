class Rule < ActiveRecord::Base
  belongs_to :rule_group
  has_many :smackdown_rules
  has_many :users, through: :player_rules
  has_many :player_rules
end
