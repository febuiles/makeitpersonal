module UserLyricsHelper
  def image_for_band(band_name)
    band = band_name.to_key
    image_tag("artists/#{band}.jpg", :class => "background")
  end
end
