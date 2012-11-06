class SongsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit, :update, :create]
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
      redirect_to user_song_path(current_user.username, @song), :notice => "The song's been updated."
    end
  end

  def create
    @song = current_user.songs.build(params[:song])
    if @song.save
      mixpanel.append_track "New Song", { artist: @song.artist, title: @song.title, user_id: @song.user.id }
      redirect_to user_song_path(current_user.username, @song)
    else
      render :new
    end
  end

  def index
    render_not_found unless @user
  end

  def show
    redirect_to root_path if params[:username] == "user_lyrics"
    @song = @user.songs.find(params[:id])
    mixpanel.append_track "Song View", { artist: @song.artist, title: @song.title }
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
