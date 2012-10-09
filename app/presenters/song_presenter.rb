module SongPresenter
  def embed
    url = youtube_url
    return unless url.present?
    return unless url.match(/youtube.com\/watch\?v=/)
    id = url.gsub(/.+v=(.\w+)/, "\\1")
    "<iframe height='23' width='265' src='http://www.youtube.com/embed/#{id}?rel=0&autohide=0&fs=0&modestbranding=1&theme=light' frameborder='0' ></iframe>".html_safe
  end

  def body
    lyrics.gsub!(/\*(.*?)\*/m, '<em>\1</em>')
    lyrics.gsub("\n", "<br/>").html_safe
  end
end
