class RelationshipsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :destroy]

  def followers
    @user = User.find(params[:username])
  end

  def following
    @user = User.find(params[:username])
  end

  def create
    followed = User.find(params[:followed_id])
    current_user.follow(followed)
    NotificationsMailer.followed(current_user, followed).deliver
    redirect_to :back, :notice => "You're now following #{followed.username}"
  end

  def destroy
    followed = User.find(params[:id])
    current_user.unfollow(followed)
    redirect_to :back, :notice => "You've stopped following #{followed.username}"
  end
end
