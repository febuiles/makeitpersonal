class SongsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit, :update, :create]

  def new
    @lyric = Song.new
  end

  def create
    @lyric = current_user.songs.build(params[:song])
    if @lyric.save
      redirect_to song_path(@lyric)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
    @user = User.find_by_username(params[:username])
    @song = @user.songs.find_by_param_title(params[:title])
  end
end
