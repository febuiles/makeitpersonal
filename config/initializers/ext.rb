class String
  def to_key
    self.strip.downcase.gsub(/ /, "-").gsub(/\./, "")
  end
end
