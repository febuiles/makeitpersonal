class ApplicationController < ActionController::Base
  before_filter :track_visit
  protect_from_forgery
  def after_sign_in_path_for(resource)
    account_path
  end

  def render_not_found
    raise ActiveRecord::RecordNotFound.new('Not Found')
  end

  protected
  def track_visit
    mixpanel.append_track "Visit"
  end

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
