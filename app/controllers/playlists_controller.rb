class PlaylistsController < ApplicationController
  def new
    @playlist = Playlist.new
  end

  def show
    @playlist = Playlist.find(params[:id])
  end

  def fetch
    @playlist = Playlist.new(params[:playlist])

    respond_to do |format|
      if @playlist.save
        format.html { render @playlist }
      else
        format.html { render :text => "Error loading the data." }
      end
    end
  end
end
