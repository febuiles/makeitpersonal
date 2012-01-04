module SongPersistable

  def list
    @playlist ||= songs.map { |json| LastFm::Song.from_json(json) }
  end

  def fetch_songs
    if songs.blank?
      begin
        self.songs = LastFm::List.new(username).between(start_date, end_date).to_json
      rescue OpenURI::HTTPError
        errors.add(:username, "doesn't exist")
        return false
      end
    end
  end
end
