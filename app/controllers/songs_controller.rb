class SongsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit, :update, :create]
  before_filter :find_user, :only => [:index, :show]

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

  def index
    @user = User.find_by_username(params[:username])
  end

  def show
    @song = @user.songs.find(params[:id])
  end

  private
  def find_user
    @user = User.find_by_username(params[:username])
  end
end
