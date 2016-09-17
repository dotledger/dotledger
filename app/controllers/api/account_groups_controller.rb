module Api
  class AccountGroupsController < BaseController
    def index
      @account_groups = AccountGroup.all

      @account_groups = @account_groups.order(:name)

      respond_with @account_groups
    end

    def show
      @account_group = AccountGroup.find(account_group_id)

      respond_with @account_group
    end

    def create
      @account_group = AccountGroup.new(account_group_params)

      @account_group.save

      respond_with @account_group
    end

    def update
      @account_group = AccountGroup.find(account_group_id)

      @account_group.update(account_group_params)

      respond_with @account_group
    end

    def destroy
      @account_group = AccountGroup.find(account_group_id)

      @account_group.destroy

      respond_with @account_group
    end

    private

    def account_group_id
      params[:id].to_s
    end

    def account_group_params
      params.permit(:name)
    end
  end
end
