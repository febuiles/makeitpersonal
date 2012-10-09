class String
  def to_key
    self.strip.downcase.gsub(/ /, "-").gsub(/\./, "")
  end

  def from_key
    self.strip.downcase.gsub(/-/, " ")
  end
end
