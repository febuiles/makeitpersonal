class SongsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit, :update, :create, :destroy]
  before_filter :find_user, :only => [:index, :show]

  def new
    @song = Song.new
  end

  def edit
    @song = current_user.songs.find(params[:id])
  end

  def update
    @song = current_user.songs.find(params[:id])
    if @song.update_attributes(params[:song])
      respond_to do |format|
        format.html { redirect_to user_song_path(current_user.username, @song), :notice => "The song's been updated." }
        format.js
      end
    end
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
    render_not_found unless @user
    @songs = @user.songs_visible_to(current_user).page(params[:page]).per(15)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @song = @user.songs.find(params[:id])
  end

  def destroy
    @song = current_user.songs.find(params[:id])
    @song.destroy
    redirect_to account_path
  end

  private
  def find_user
    @user = User.find_by_slug(params[:username].downcase)
  end
end
