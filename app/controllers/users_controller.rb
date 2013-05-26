class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = current_user

    @songs = Kaminari.paginate_array(@user.timeline_songs).page(params[:page]).per(15)

  end
end
