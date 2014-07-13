# FIXME: This needs some work

module Api
  class StatisticsController < BaseController
    include DateRangeParams

    def activity_per_category
      set_metadata_header(
        date_from: date_range.first,
        date_to: date_range.last
      )
      @activity_per_category = Statistics::ActivityPerCategory.new(date_range)
      render json: @activity_per_category
    end
  end
end
