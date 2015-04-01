class DotLedgerExporter
  attr_accessor :file, :data

  def initialize(file = nil)
    @file = file
    @data = {}
  end

  def export
    export_accounts
    export_categories
    export_sorting_rules
    export_goals

    file.write(data.to_yaml) if file

    true
  end

  def export_accounts
    data['Accounts'] = Account.all.map do |account|
      account.slice(:name, :number, :type).to_hash
    end
  end

  def export_categories
    data['Categories'] = Category.all.map do |category|
      category.slice(:name, :type).to_hash
    end
  end

  def export_sorting_rules
    data['SortingRules'] = SortingRule.all.map do |sorting_rule|
      sorting_rule.slice(:name, :contains, :category_name, :tag_list, :review).to_hash
    end
  end

  def export_goals
    data['Goals'] = Goal.all.map do |goal|
      goal.slice(:category_name, :amount, :period).tap do |goal_hash|
        goal_hash[:amount] = goal_hash[:amount].to_f
      end.to_hash
    end
  end
end
