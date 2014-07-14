class RuleGroup < ActiveRecord::Base
  belongs_to :game
  has_many :rules
end
