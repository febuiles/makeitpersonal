class String
  def to_key
    self.strip.downcase.gsub(/ /, "-").gsub(/\./, "")
  end

  def from_key
    self.strip.downcase.gsub(/-/, " ")
  end

  def replace_newlines
    gsub!(/(\r?\n){2,}/, "<br/><br/>")
    gsub(/(\r?\n)/, "<br/>").html_safe
  end

  def titleize_with_caps
    strings = split
    strings.each do |str|
      str[0] = str[0].capitalize
    end
    strings.join(" ")
  end

  def possessive
    if self[-1, 1] == "s"
      "#{self}'"
    else
      "#{self}'s"
    end
  end
end
