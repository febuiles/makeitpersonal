require 'uri'
require 'cgi'
require 'active_support/core_ext/object'

class YoutubeParser
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def embed_code
    return nil if url_invalid?
    "<iframe class='youtube-embed' src='#{src}?#{default_params}' frameborder='0' ></iframe>"
  end

  private

  def src
    "http://www.youtube.com/embed/#{video_id}"
  end

  def video_id
    query = URI.parse(url).query
    CGI.parse(query)["v"].first
  end

  def default_params
    { rel: 0, autohide: 1, fs: 0, branding: 1, theme: "light" }.to_query
  end

  def url_invalid?
    url.nil? or !url.match(/youtube.com\/watch\?v=/)
  end
end
