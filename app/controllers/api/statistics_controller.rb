# FIXME: This needs some work

module Api
  class StatisticsController < BaseController
    include DateRangeParams

    def activity_per_category
      @activity_per_category = Statistics::ActivityPerCategory.new(date_range)
      set_metadata_header(
        date_from: date_range.first,
        date_to: date_range.last,
        total_spent: @activity_per_category.total_spent,
        total_received: @activity_per_category.total_received,
        total_net: @activity_per_category.total_net
      )
      render json: @activity_per_category
    end
  end
end
