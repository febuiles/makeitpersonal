class RelationshipsController < ApplicationController
  before_filter :authenticate_user!

  def create
    followed = User.find(params[:followed_id])
    current_user.follow(followed)
    NotificationsMailer.followed(current_user, followed).deliver
    redirect_to account_path, :notice => "You're now following #{followed.username}"
  end

  def destroy
    followed = User.find(params[:id])
    current_user.unfollow(followed)
    redirect_to account_path, :notice => "You've stopped following #{followed.username}"
  end
end
