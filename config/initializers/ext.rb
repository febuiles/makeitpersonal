class String
  def to_key
    self.strip.downcase.gsub(/ /, "-")
  end
end
