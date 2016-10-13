# FIXME: This needs some work

module Api
  class StatisticsController < BaseController
    include DateRangeParams

    def activity_per_category
      @activity_per_category = ActivityPerCategory.new(date_range)
      set_metadata_header(
        date_from: date_range.first,
        date_to: date_range.last,
        total_spent: @activity_per_category.total_spent,
        total_received: @activity_per_category.total_received,
        total_net: @activity_per_category.total_net
      )
      render json: @activity_per_category
    end

    def activity_per_category_type
      @activity_per_category_type = ActivityPerCategoryType.new(date_range)
      set_metadata_header(
        date_from: date_range.first,
        date_to: date_range.last,
        total_spent: @activity_per_category_type.total_spent,
        total_received: @activity_per_category_type.total_received,
        total_net: @activity_per_category_type.total_net
      )
      render json: @activity_per_category_type
    end
  end
end
