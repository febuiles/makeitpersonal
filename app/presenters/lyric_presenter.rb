class LyricPresenter
  include ActionView::Helpers::DateHelper
  attr_reader :song

  def initialize(song)
    @song = song
  end

  def self.model_name
    "LyricPresenter"
  end

  def title
    "#{song.artist} &ndash; #{song.title}".html_safe
  end

  def embed
    url = song.youtube_url.sub("watch?v=", "embed/")
    "<iframe width=\"600\" height=\"345\" src=\"#{url}\" frameborder=\"0\" allowfullscreen></iframe>".html_safe
  end

  def info
    "Posted by <a href='#'>kezia</a>, #{time_ago_in_words(song.created_at)} ago.".html_safe
  end

  def lyrics
    song.lyrics.gsub("\n", "<br/>").html_safe
  end
end
