module Api
  class CategoriesController < BaseController
    def index
      @categories = Category.all

      respond_with @categories
    end

    def show
      @category = Category.find(category_id)

      respond_with @category
    end

    def create
      @category = Category.new(category_params)

      @category.save

      respond_with @category
    end

    def update
      @category = Category.find(category_id)

      @category.update(category_params)

      respond_with @category
    end

    def destroy
      @category = Category.find(category_id)

      @category.destroy

      respond_with @category
    end

    private

    def category_id
      params[:id].to_s
    end

    def category_params
      params.permit(:name, :type)
    end
  end
end
