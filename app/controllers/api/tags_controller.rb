module Api
  class TagsController < BaseController
    def index
      @tags = Tag.all

      @tags = @tags.order(:name)

      respond_with @tags
    end
  end
end
