module Api
  class SavedSearchesController < BaseController
    def index
      @saved_searches = SavedSearch.all

      @saved_searches = @saved_searches.order(:name)

      respond_with @saved_searches
    end

    def show
      @saved_search = SavedSearch.find(saved_search_id)

      respond_with @saved_search
    end

    def create
      @saved_search = SavedSearch.new(saved_search_params)

      @saved_search.save

      respond_with @saved_search
    end

    def update
      @saved_search = SavedSearch.find(saved_search_id)

      @saved_search.update(saved_search_params)

      respond_with @saved_search
    end

    def destroy
      @saved_search = SavedSearch.find(saved_search_id)

      @saved_search.destroy

      respond_with @saved_search
    end

    private

    def saved_search_id
      params[:id].to_s
    end

    def saved_search_params
      params.permit(:name, :query, :category_id, :category_type, :date_from,
        :date_to, :account_id, :review, :period_from, :period_to, tag_ids: [])
    end
  end
end
