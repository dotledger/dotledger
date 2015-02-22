module Api
  class SortingRulesController < BaseController
    def index
      @sorting_rules = SortingRule.includes(:category)

      @sorting_rules = @sorting_rules.order(:name, :contains)

      @sorting_rules = @sorting_rules.page(page_number)

      @sorting_rules = @sorting_rules.with_category(params[:category_id]) if filter_with_category

      @sorting_rules = @sorting_rules.with_tags(params[:tag_ids]) if filter_with_tags

      @sorting_rules = @sorting_rules.search_query(params[:query]) if filter_search_query

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

    def filter_search_query
      params.key?(:query)
    end

    def filter_with_category
      params.key?(:category_id)
    end

    def filter_with_tags
      params.key?(:tag_ids)
    end

    def sorting_rule_id
      params[:id].to_s
    end

    def sorting_rule_params
      params.permit(:name, :contains, :category_id, :review, :tags)
    end
  end
end
