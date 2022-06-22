# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :set_notifications, if: :current_user
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_in_path_for(_user)
    flash[:alert] = nil
    dashboards_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end

  private

  def user_not_authorized
    flash[:danger] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || dashboards_path)
  end

  def set_notifications
    @notifications = Notification.where(recipient: current_user).newest_first
    @unread = @notifications.unread
    @read = @notifications.read
  end
end
