class UserLyricsController < ApplicationController
  layout :set_song_layout

  before_filter :authenticate_user!, :only => [:new, :edit, :update, :create]

  def new
    @lyric = UserLyric.new
  end

  def create
    @lyric = current_user.user_lyrics.build(params[:user_lyric])
    if @lyric.save
      redirect_to user_lyric_path(@lyric)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
    lyric = UserLyric.find(params[:id])
    @lyric = UserLyricPresenter.new(lyric)
  end

  def set_song_layout
    if action_name == "show"
      "song"
    else
      "application"
    end
  end
end
