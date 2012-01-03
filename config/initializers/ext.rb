class String
  def to_key
    self.downcase.gsub(/ /, "-")
  end
end
