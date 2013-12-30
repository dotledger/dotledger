# FIXME: This needs some work

module Api
  class StatisticsController < BaseController
    def activity_per_category
      @activity_per_category = Statistics::ActivityPerCategory.new(date_range)
      render :json => @activity_per_category
    end

    private
    def date
      Date.parse(params[:date].to_s)
    rescue ArgumentError
      Date.today
    end

    def date_range
      Date.parse(params[:date_from].to_s)..Date.parse(params[:date_to].to_s)
    rescue ArgumentError
      month_date_range(date)
    end

    def month_date_range(seed_date)
      seed_date.beginning_of_month..seed_date.end_of_month
    end
  end
end
