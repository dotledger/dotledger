module Api
  class BaseController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :default_format_json
    respond_to :json

    def self.responder
      ApiResponder
    end

    private

    def page_number
      params[:page]
    end

    def set_metadata_header(metadata)
      headers['X-Metadata'] = metadata.to_json
    end

    def set_pagination_header(collection)
      first_page = collection.current_page == 1
      last_page = collection.current_page == collection.total_pages
      last_page = true if collection.total_pages == 0
      previous_page = first_page ? nil : collection.current_page - 1
      next_page = last_page ? nil : collection.current_page + 1

      headers['X-Pagination'] = {
        total_pages: collection.total_pages,
        total_items: collection.total_count,
        current_page: collection.current_page,
        next_page: next_page,
        previous_page: previous_page,
        first_page: first_page,
        last_page: last_page
      }.to_json
    end

    def default_format_json
      return unless request.headers['HTTP_ACCEPT'].nil? && params[:format].nil?
      request.format = 'json'
    end
  end
end
