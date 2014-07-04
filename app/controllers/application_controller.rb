class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate

  def boot
  end

  private

  def authenticate
    if Rails.application.secrets.authentication.present?
      authenticate_with_http_basic do |username, password|
        Rails.application.secrets.authentication['credentials'].any? do |credentials|
          username == credentials['username'] && password == credentials['password']
        end
      end || request_http_basic_authentication
    end
  end
end
