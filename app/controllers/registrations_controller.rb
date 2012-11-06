class RegistrationsController < Devise::RegistrationsController
  layout :set_layout

  def create
    super
    mixpanel.append_track "User Signup", { :user_id => resource.id }
  end

  def update
    @user = User.find(current_user.id)
    password_changed = !params[:user][:password].empty?

    successfully_updated = if password_changed
      @user.update_with_password(params[:user])
    else
      @user.update_without_password(params[:user])
    end

    if successfully_updated
      sign_in @user, :bypass => true
      redirect_to edit_user_registration_path, :notice => "Updated."
    else
      render "edit"
    end
  end

  protected

  def set_layout
    action_name == "edit" ? "application" : "devise"
  end

  def mixpanel
    @mixpanel ||= Mixpanel::Tracker.new ENV["MIXPANEL_TOKEN"], { :env => request.env, persist: true }
  end
end
