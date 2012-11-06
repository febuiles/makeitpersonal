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
    @mixpanel ||= Mixpanel::Tracker.new ENV["MIXPANEL_TOKEN"], { :env => request.env, persist: true }
  end
end
