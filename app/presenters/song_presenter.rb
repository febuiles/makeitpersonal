module SongPresenter
  include ActionView::Helpers::UrlHelper

  def name
    if user.trustable?
      "#{artist} &mdash; #{title}".html_safe
    else
      "#{artist.titleize_with_caps} &mdash; #{title.titleize_with_caps}".html_safe
    end
  end

  def embed
    YoutubeParser.new(youtube_url).embed_code.html_safe
  end

  def sidenotes
    parser.sidenotes.join.html_safe
  end

  def body
    parser.lyrics.html_safe
  end

  private

  def parser
    @parser ||= SongParser.new(lyrics)
  end
end
