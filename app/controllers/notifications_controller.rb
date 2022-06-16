# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.where(recipient: current_user).newest_first
    @unread = @notifications.unread
    @read = @notifications.read
  end
end
