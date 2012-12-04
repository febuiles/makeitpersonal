class String
  def to_key
    self.strip.downcase.gsub(/ /, "-").gsub(/\./, "")
  end

  def from_key
    self.strip.downcase.gsub(/-/, " ")
  end

  # we can't use Rails' #titleize since we need to deal with stuff like
  # "LCD Soundsystem"
  def titleize_with_caps
    strings = split
    strings.each do |str|
      str[0] = str[0].capitalize
    end
    strings.join(" ")
  end

  def underscored
    gsub(" ", "_")
  end

  def possessive
    if self[-1, 1] == "s"
      "#{self}'"
    else
      "#{self}'s"
    end
  end
end
