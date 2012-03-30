require "presenter"

class UserLyricPresenter < Presenter
  def title
    "#{record.artist.titleize} &ndash; #{record.title.titleize}".html_safe
  end

  def embed
    url = record.youtube_url
    return unless url.present?
    return unless url.match(/youtube.com\/watch\?v=/)

    url = url.sub("watch?v=", "embed/")
    "<iframe width=\"600\" height=\"345\" src=\"#{url}\" frameborder=\"0\" allowfullscreen></iframe>".html_safe
  end

  def lyrics
    record.lyrics.gsub!(/\*(.*?)\*/m, '<em>\1</em>')
    record.lyrics.gsub("\n", "<br/>").html_safe
  end
end
