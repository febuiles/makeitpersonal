module RegistrationsHelper
  def resource_name
    :user
  end

  def resource
    @resource = @resource || current_user || User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
