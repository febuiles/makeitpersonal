class ApplicationController < ActionController::Base
  before_filter :show_welcome_notice

  protect_from_forgery

  def after_sign_in_path_for(resource)
    account_path
  end

  def render_not_found
    raise ActiveRecord::RecordNotFound.new('Not Found')
  end

  def show_welcome_notice
    if request.format.html? && !current_user && session[:first_time].nil?
      @show_welcome_notice = true
      session[:first_time] = false
    end
  end
end
