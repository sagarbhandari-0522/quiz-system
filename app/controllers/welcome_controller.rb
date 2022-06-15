# frozen_string_literal: true

class WelcomeController < ApplicationController
  layout 'devise', only: %i[index]
  def index
    redirect_to(dashboards_path) if user_signed_in?
  end
end
