class RuleGroup < ActiveRecord::Base
  belongs_to :game
  has_many :rules
  def gameAndRuleGroupName
    return game.name + "-" + name
  end
end
