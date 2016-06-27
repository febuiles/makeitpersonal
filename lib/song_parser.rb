require 'uri'
require 'cgi'
require 'markdown_renderer'

class SongParser
  include ActionView::Helpers::SanitizeHelper

  attr_reader :lyrics, :sidenotes
  SIDENOTE_REGEX = /\[\[(.*?)\]\]/m

  def initialize(lyrics)
    @lyrics = lyrics
    @sidenotes = get_sidenotes
    replace_ems
    clean_lyrics
    replace_newlines
  end

  private

  def get_sidenotes
    sidenotes = lyrics.scan(SIDENOTE_REGEX).flatten
    res = sidenotes.each_with_index.map do |note, i|
      index = "**[#{i + 1}]**"
      markdown.render("#{index} #{note}")
    end.join
    sanitize(res, tags: %w(strong em a img p code pre), attributes: %w(href src))
  end

  def clean_lyrics
    lyrics.scan(SIDENOTE_REGEX).count.times do |i|
      lyrics.sub!(SIDENOTE_REGEX, "<span class='sidenote-ref'>[#{i + 1}]</span>")
    end
  end

  def replace_ems
    @lyrics.gsub!(/\*(.*?)\*/m, '<em>\1</em>')
  end

  def replace_newlines
    @lyrics.gsub!(/(\r?\n){2,}/, "<br/><br/>")
    @lyrics.gsub!(/(\r?\n)/, "<br/>")
  end

  def markdown
    @markdown ||= MarkdownRenderer.new
  end
end
