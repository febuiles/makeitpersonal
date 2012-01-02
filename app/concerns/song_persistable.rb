module SongPersistable
  def fetch_songs
    if songs.blank?
      self.songs = LastFm::List.new(username).between(start_date, end_date).to_json
    end
  end
end
