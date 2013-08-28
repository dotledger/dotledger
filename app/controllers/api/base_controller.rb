module Api
  class BaseController < ApplicationController 
    skip_before_filter :verify_authenticity_token  
    before_filter :default_format_json
    respond_to :json

    def self.responder
      ApiResponder
    end

    private
    def default_format_json
      if(request.headers["HTTP_ACCEPT"].nil? &&
         params[:format].nil?)
        request.format = "json"
      end
    end
  end
end
