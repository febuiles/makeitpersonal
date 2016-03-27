class RegistrationsController < Devise::RegistrationsController
  layout :set_layout

  def new
    super
  end

  def create
    super
    return if resource.new_record?
    NotificationsMailer.new_user(resource).deliver
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
end
