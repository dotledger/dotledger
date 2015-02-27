module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate
  end

  def authenticate
    return unless Rails.application.secrets.authentication.present?

    authenticate_with_http_basic do |username, password|
      Rails.application.secrets.authentication['credentials'].any? do |credentials|
        username == credentials['username'] && password == credentials['password']
      end
    end || request_http_basic_authentication
  end
end
