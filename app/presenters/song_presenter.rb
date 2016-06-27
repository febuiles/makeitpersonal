module SongPresenter
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::SanitizeHelper

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def white_list_sanitizer
      HTML::WhiteListSanitizer.new
    end
  end

  def name
    if user.trustable?
      "#{artist} — #{title}"
    else
      "#{artist.titleize_with_caps} — #{title.titleize_with_caps}"
    end
  end

  def youtube_embed
    YoutubeParser.new(youtube_url).embed_code
  end

  def sidenotes
    parser.sidenotes
  end

  def body
    sanitize(parser.lyrics, tags: %w(span strong em br p), attributes: %w(class))
  end

  private

  def parser
    @parser ||= SongParser.new(lyrics)
  end
end
