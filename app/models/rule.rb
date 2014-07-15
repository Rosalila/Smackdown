class Rule < ActiveRecord::Base
  belongs_to :rule_group
  has_many :smackdown_rules
end
