class DotLedgerImporter
  attr_accessor :file, :data

  def initialize(file)
    @file = file
    @data = {}
  end

  def import
    import_accounts
    import_categories
    import_sorting_rules
    import_goals

    true
  end

  def import_accounts
    load_yaml

    data['Accounts'] = yaml.fetch('Accounts', []).map do |account|
      new_account = Account.where(account).first_or_initialize
      new_account.tap(&:save!)
    end
  end

  def import_categories
    load_yaml

    data['Categories'] = yaml.fetch('Categories', []).map do |category|
      new_category = Category.where(category).first_or_initialize
      new_category.tap(&:save!)
    end
  end

  def import_sorting_rules
    load_yaml

    data['SortingRules'] = yaml.fetch('SortingRules', []).map do |sorting_rule|
      category = Category.where(name: sorting_rule.delete('category_name')).first
      tag_list = sorting_rule.delete('tag_list')
      new_sorting_rule = SortingRule.where(
        sorting_rule.merge(category_id: category.id)
      ).first_or_initialize
      new_sorting_rule.tag_list = tag_list if tag_list
      new_sorting_rule.tap(&:save!)
    end
  end

  def import_goals
    load_yaml

    data['Goals'] = yaml.fetch('Goals', []).map do |goal|
      category = Category.where(name: goal.delete('category_name')).first
      new_goal = Goal.where(
        category_id: category.id
      ).first_or_initialize
      new_goal.assign_attributes(goal)
      new_goal.tap(&:save!)
    end
  end

  private

  def load_yaml
    @yaml ||= YAML.safe_load(file.read)
  end

  attr_reader :yaml
end
