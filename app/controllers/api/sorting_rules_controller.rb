module Api
  class SortingRulesController < BaseController
    def index
      @sorting_rules = SortingRule.includes(:category)

      @sorting_rules = @sorting_rules.order(:name, :contains)
      
      @sorting_rules = @sorting_rules.page(page_number)

      set_pagination_header(@sorting_rules)

      respond_with @sorting_rules
    end

    def show
      @sorting_rule = SortingRule.find(sorting_rule_id)

      respond_with @sorting_rule
    end

    def create
      @sorting_rule = SortingRule.new(sorting_rule_params)

      @sorting_rule.save

      respond_with @sorting_rule
    end

    def update
      @sorting_rule = SortingRule.find(sorting_rule_id)

      @sorting_rule.update(sorting_rule_params)

      respond_with @sorting_rule
    end

    def destroy
      @sorting_rule = SortingRule.find(sorting_rule_id)

      @sorting_rule.destroy

      respond_with @sorting_rule
    end

    private

    def sorting_rule_id
      params[:id].to_s
    end

    def sorting_rule_params
      params.permit(:name, :contains, :category_id, :review, :tags)
    end
  end
end
