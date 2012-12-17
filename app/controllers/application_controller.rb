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

  protected

  def mixpanel
    env = {
      'REMOTE_ADDR' => request.env['REMOTE_ADDR'],
      'HTTP_X_FORWARDED_FOR' => request.env['HTTP_X_FORWARDED_FOR'],
      'rack.session' => request.env['rack.session'],
      'mixpanel_events' => request.env['mixpanel_events']
    }

    @mixpanel ||= Mixpanel::Tracker.new ENV["MIXPANEL_TOKEN"], { env: env, persist: true }
  end
end
