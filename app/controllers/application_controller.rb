class ApplicationController < ActionController::Base
  protect_from_forgery
  def after_sign_in_path_for(resource)
    account_path
  end

  def render_not_found
    raise ActiveRecord::RecordNotFound.new('Not Found')
  end
end
