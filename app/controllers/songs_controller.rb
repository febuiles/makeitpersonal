class SongsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit, :update, :create]
  before_filter :find_user, :only => [:index, :show]

  def new
    @song = Song.new
  end

  def edit
    @song = @user.songs.find(params[:id])
  end

  def update
  end

  def create
    @song = current_user.songs.build(params[:song])
    if @song.save
      redirect_to user_song_path(current_user.username, @song)
    else
      render :new
    end
  end

  def index
    @user = User.find_by_username(params[:username])
    render_not_found unless @user
  end

  def show
    @song = @user.songs.find(params[:id])
  end

  def destroy
    @song = @user.songs.find(params[:id])
    @song.destroy if current_user.owns?(@song)
    redirect_to songs_path
  end

  private
  def find_user
    @user = User.find_by_username(params[:username])
  end
end
