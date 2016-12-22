class SavedSearchSerializer < ActiveModel::Serializer
  attributes :id, :name, :query, :category_id, :category_type, :date_from,
    :date_to, :tag_ids, :tag_list, :account_id, :review, :period_from,
    :period_to, :actual_date_from, :actual_date_to, :created_at, :updated_at

  def actual_date_from
    case object.period_from
    when 'Beginning of year'
      DateTime.now.beginning_of_year
    when 'Beginning of quarter'
      DateTime.now.beginning_of_quarter
    when 'Beginning of month'
      DateTime.now.beginning_of_month
    when 'Beginning of week'
      DateTime.now.beginning_of_week
    else
      object.date_from
    end
  end

  def actual_date_to
    case object.period_to
    when 'End of year'
      DateTime.now.end_of_year
    when 'End of quarter'
      DateTime.now.beginning_of_quarter
    when 'End of month'
      DateTime.now.end_of_month
    when 'End of week'
      DateTime.now.end_of_week
    when 'Today'
      DateTime.now
    else
      object.date_to
    end
  end
end
