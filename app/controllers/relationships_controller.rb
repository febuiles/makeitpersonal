class RelationshipsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :destroy]

  def followers
    @user = User.find(params[:username])
  end

  def following
    @user = User.find(params[:username])
  end

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    NotificationsMailer.followed(current_user, @user).deliver
    respond_to do |format|
      format.html { redirect_to :back, :notice => "You're now following #{@user.username}"}
      format.js
    end
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to :back, :notice => "You've stopped following #{@user.username}"}
      format.js
    end
  end
end
