module Api
  class GoalsController < BaseController
    def index
      @goals = Goal.includes(:category)
      
      @goals = @goals.order('categories.type ASC, categories.name')

      respond_with @goals
    end

    def show
      @goal = Goal.find(goal_id)

      respond_with @goal
    end

    def create
      @goal = Goal.new(goal_params)

      @goal.save

      respond_with @goal
    end

    def update
      @goal = Goal.find(goal_id)

      @goal.update(goal_params)

      respond_with @goal
    end

    def destroy
      @goal = Goal.find(goal_id)

      @goal.destroy

      respond_with @goal
    end

    private

    def goal_id
      params[:id].to_s
    end

    def goal_params
      params.permit(:category_id, :amount, :period)
    end
  end
end
